interface zif_otel_tracer_provider
  public .

   " get tracer
  methods get_tracer
    importing name type string optional
    returning value(result) type ref to zif_otel_tracer.

endinterface.
