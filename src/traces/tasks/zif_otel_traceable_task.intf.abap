interface zif_otel_traceable_task
  public .
    " execute with trace
    methods execute
      importing span type ref to zif_otel_span
      raising cx_static_check.
endinterface.
