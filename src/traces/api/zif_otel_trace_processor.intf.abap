interface zif_otel_trace_processor
  public .

  methods on_span_start
    importing
        tracer type ref to zif_otel_tracer
        span type ref to zif_otel_span
        stack_depth type i optional.

  methods on_span_event
    importing
        tracer type ref to zif_otel_tracer
        span type ref to zif_otel_span
        event type ref to zif_otel_span_event
        stack_depth type i optional.

  methods on_span_end
    importing
        tracer type ref to zif_otel_tracer
        span type ref to zif_otel_span
        stack_depth type i optional.

endinterface.
