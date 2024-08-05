class zcl_otel_trace_controller definition
  public
  final
  create private global friends zcl_otel_trace.

  public section.
  interfaces zif_otel_trace_api.
  private section.
    data processors type table of ref to zif_otel_trace_processor with empty key.

     methods:
      on_span_start for event span_start of zcl_otel_tracer
        importing span,
      on_span_end for event span_end of zcl_otel_tracer
        importing span,
      on_span_event for event span_event of zcl_otel_tracer
        importing span_event.

endclass.



class zcl_otel_trace_controller implementation.

  method zif_otel_trace_api~use.
    append processor to processors.
  endmethod.

   method on_span_start.
    loop at processors into data(processor).
      processor->on_span_start( span = span ).
    endloop.
  endmethod.
  method on_span_event.
    loop at processors into data(processor).
      processor->on_span_event( event = span_event ).
    endloop.
  endmethod.
  method on_span_end.
    loop at processors into data(processor).
      processor->on_span_end( span = span ).
    endloop.
  endmethod.

  method zif_otel_trace_api~get_tracer.
    data(tracer) = new zcl_otel_tracer( ).
    set handler
        on_span_start
        on_span_event
        on_span_end for tracer.
    result = tracer.
  endmethod.


endclass.
