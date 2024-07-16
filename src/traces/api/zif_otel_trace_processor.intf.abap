interface zif_otel_trace_processor
  public .

  methods on_span_start
    importing span type ref to zif_otel_span.

  methods on_span_event
    importing span_event type ref to zif_otel_span_event.

  methods on_span_end
    importing span type ref to zif_otel_span.

endinterface.
