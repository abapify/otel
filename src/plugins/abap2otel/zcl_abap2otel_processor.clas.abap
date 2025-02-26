class zcl_abap2otel_processor definition
  public
  final
  create public .

  public section.

    types buffer_type type ref to zcl_abap2otel_msg.

    methods constructor importing buffer type buffer_type.

    interfaces zif_otel_metrics_processor .
    interfaces zif_otel_trace_processor .

  protected section.
  private section.

    data buffer type ref to zcl_abap2otel_msg.

endclass.

class zcl_abap2otel_processor implementation.

  method zif_otel_trace_processor~on_span_end.

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

  method zif_otel_trace_processor~on_span_event.

  endmethod.

  method zif_otel_trace_processor~on_span_start.

  endmethod.

  method zif_otel_metrics_processor~on_metric_value_added.

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

    me->buffer = cond #(  when buffer is bound then buffer else new #(  ) ).

  endmethod.

endclass.
