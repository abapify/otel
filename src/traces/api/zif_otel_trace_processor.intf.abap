interface zif_otel_trace_processor
  public .

  methods on_span_start
    importing span type ref to zif_otel_span
        stack_depth type i optional.

  methods on_span_event
    importing event type ref to zif_otel_span_event
        stack_depth type i optional.

  methods on_span_end
    importing span type ref to zif_otel_span
        stack_depth type i optional.

endinterface.
