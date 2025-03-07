interface zif_otel_api
  public .

  methods trace returning value(result) type ref to zif_otel_trace_api.
  methods logs returning value(result) type ref to zif_otel_logs_api.
  methods metrics returning value(result) type ref to zif_otel_metrics_api.

endinterface.
