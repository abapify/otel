interface zif_otel_api_manager
  public .

  methods trace returning value(result) type ref to zif_otel_trace_api_manager.
  methods logs returning value(result) type ref to zif_otel_logs_api_manager.
  methods metrics returning value(result) type ref to zif_otel_metrics_api_manager.

endinterface.
