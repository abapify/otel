interface zif_otel_collector
  public .

  interfaces zif_otel_trace_collector.
  interfaces zif_otel_logs_collector.
  interfaces zif_otel_metrics_collector.

  aliases add_trace for zif_otel_trace_collector~add_span.
  aliases add_metric for zif_otel_metrics_collector~add_metric.
  aliases add_log for zif_otel_logs_collector~add_log.

endinterface.
