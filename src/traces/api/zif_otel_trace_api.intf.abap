interface zif_otel_trace_api
  public .

  methods get_tracer_provider returning value(result) type ref to zif_otel_tracer_provider.

   " get tracer
  methods get_tracer
    importing name type string optional
    returning value(result) type ref to zif_otel_tracer.


endinterface.
