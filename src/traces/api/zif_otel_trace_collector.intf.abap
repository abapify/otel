interface zif_otel_trace_collector
  public .

  methods add_span
    importing
        "resource type ref to zif_otel_resource
        tracer type ref to zif_otel_tracer
        span type ref to zif_otel_span.

endinterface.
