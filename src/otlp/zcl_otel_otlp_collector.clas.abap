class zcl_otel_otlp_collector definition
  public
  final
  create public .

  public section.
    interfaces zif_otel_collector.
  protected section.
  private section.

    methods resource importing resource      type ref to zif_otel_resource
                     returning value(result) type zif_otel_otlp_resource=>resource.

    methods scope importing resource      type ref to zif_otel_scope
                  returning value(result) type zif_otel_otlp_common=>instrumentation_scope.

    methods attributes importing attributes    type ref to zif_otel_attribute_map
                       returning value(result) type zif_otel_otlp_common=>key_value_list-values.

    methods timestamp importing timestamp type timestampl returning value(result) type string.

    data buffer type zif_otel_otlp=>schema.

endclass.



class zcl_otel_otlp_collector implementation.
  method zif_otel_logs_collector~add_log.

  endmethod.

  method zif_otel_metrics_collector~add_metric.

  endmethod.

  method zif_otel_trace_collector~add_span.

    types resource_span_type like line of me->buffer-resource_spans.

    check span is bound.

    append value resource_span_type(
    " ToDo: to think of what could be a resource
*      resource = value #(   )
      scope_spans = value #(
        ( scope = scope( tracer )
          spans = value #( (

           trace_id = span->trace_id
           span_id = span->span_id
           parent_span_id = span->parent_span_id
*          trace_state
*          flags
*          dropped_attributes_count
          name = span->name
          kind = span->kind
          start_time_unix_nano = timestamp( span->start_time  )
          end_time_unix_nano = timestamp( span->end_time  )
          attributes  = attributes( span->attributes( ) )
          events = value #(
            for event in span->events
            (
             time_unix_nano  = timestamp( event->timestamp )
             name = event->name
             attributes = attributes( event->attributes( ) )
             "dropped_attributes_count TYPE i,
            )
          )
          links = value #(
           for link in span->links
           (
              trace_id = link->context->trace_id
              span_id = link->context->span_id
*              trace_state            TYPE string,
*              attributes
*              dropped_attributes_count TYPE i,
*              flags                  TYPE i,

           )
          )
*          dropped_events_count  TYPE i,
*          dropped_links_count   TYPE i,
*          status               TYPE status,


           ) ) )
      )
*      schema_url TYPE string,
    ) to me->buffer-resource_spans.

  endmethod.

  method resource.

  endmethod.

  method scope.

  endmethod.

  method attributes.

    check attributes is bound.

    result = value #(
          for attr in attributes->entries( )
          ( key = attr-name value = value #( string_value = attr-value ) )
          ).

  endmethod.

  method timestamp.

    result = |{ timestamp timestamp = (cl_abap_format=>ts_raw) }|.

  endmethod.

endclass.
