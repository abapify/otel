class zcl_abap2otel_collector definition
  public
  final
  create public .

  public section.

    types buffer_type type ref to zcl_abap2otel_msg.

    methods constructor importing buffer type buffer_type.

    interfaces zif_otel_collector.

  protected section.
  private section.

    data buffer type ref to zcl_abap2otel_msg.

endclass.

class zcl_abap2otel_collector implementation.

  method zif_otel_collector~add_trace.

    check buffer is bound.
    check span is bound.

    buffer->add_span( value #(
      name           = span->name
      span_id        = to_lower( conv string( span->span_id ) )
      trace_id       = to_lower( conv string( span->trace_id ) )
      parent_span_id = to_lower( conv string( span->parent_span_id ) )
      start_time     = span->start_time
      end_time       = span->end_time
      attrs          = span->attributes(  )->entries(  )
      events         = value #(
        for event in span->events
        ( name      = event->name
          attrs = event->attributes(  )->entries(  )
          timestamp = event->timestamp
        )
        )
*      status         = span->status
      links          = value #(
        for link in span->links
        ( span_id   = link->context->span_id
          trace_id  = link->context->trace_id
       )
       )
    )  ).

  endmethod.

  method zif_otel_collector~add_metric.

    check buffer is bound.
    check meter is bound.
    check metric is bound.
    check data_point is bound.

    buffer->add_metric( value #(
       name        = metric->name
       type        = metric->type
       description = metric->options-description
       unit        = metric->options-unit
       value_type = metric->options-value_type
       data_points = value #(
              (
                value = data_point->value
                ts = data_point->timestamp
                attrs = value #(
                for entry in data_point->attributes( )->entries( )
                where ( value is not initial )
                ( entry ) )
               )
             )
    ) ).

  endmethod.

  method constructor.

    me->buffer = cond #( when buffer is bound then buffer else new #( ) ).

  endmethod.

  method zif_otel_collector~add_log.

    check logger is bound.
    check log_record is bound.

    " handling context if provided
    if log_record->context is bound.
      try.
          data(span_context) = cast zif_otel_span_context( log_record->context ).
          data(span_context_data) = span_context->get_span_context( ).
        catch cx_sy_move_cast_error.
      endtry.
    endif.

    buffer->add_log( value #(
      attrs = cond #( when log_record->attributes is bound then log_record->attributes->entries( ) )
      " it must be string to support 0 values
      " otherwise in combination with intital_components = suppress
      " during transformation value will be removed
      body = log_record->body
      ts = log_record->timestamp
      severity = log_record->severity
      trace_id = span_context_data-trace_id
      span_id = span_context_data-span_id
    ) ).


  endmethod.

endclass.
