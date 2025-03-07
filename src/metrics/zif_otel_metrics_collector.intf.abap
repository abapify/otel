interface zif_otel_metrics_collector
  public .

  methods add_metric importing
    meter type ref to zif_otel_meter
    metric type ref to zif_otel_metric
    data_point type ref to zif_otel_data_point.

endinterface.
