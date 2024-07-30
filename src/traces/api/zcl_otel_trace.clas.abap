class zcl_otel_trace definition
  public
  final
  create private .

  public section.
    interfaces zif_otel_trace_api.
    class-data api type ref to zif_otel_trace_api read-only.
    class-methods: class_constructor.

  protected section.
  private section.

    methods constructor.

    data delegate_processor type ref to zif_otel_trace_processor.
    data delegate_provider type ref to zif_otel_trace_provider.


    methods:
      on_span_start for event span_start of zcl_otel_tracer
        importing span,
      on_span_end for event span_end of zcl_otel_tracer
        importing span,
      on_span_event for event span_event of zcl_otel_tracer
        importing span_event.

endclass.

class zcl_otel_trace implementation.

  method constructor.
    data(lo_delegate) = new lcl_trace_processor(  ).
    me->delegate_processor = lo_delegate.
    me->delegate_provider = lo_delegate.
  endmethod.

  method class_constructor.

    api = new zcl_otel_trace( ).

  endmethod.

  method zif_otel_trace_api~get_tracer.

    data(tracer) = new zcl_otel_tracer(  ).

    set handler
        on_span_start
        on_span_event
        on_span_end for tracer.

    result = tracer.

  endmethod.

  method on_span_end.
    delegate_processor->on_span_end( span = span ).
  endmethod.

  method on_span_event.
    delegate_processor->on_span_event( event = span_event ).
  endmethod.

  method on_span_start.
    delegate_processor->on_span_start( span = span ).
  endmethod.

  method zif_otel_trace_provider~use.
    delegate_provider->use( processor ).
  endmethod.

endclass.
