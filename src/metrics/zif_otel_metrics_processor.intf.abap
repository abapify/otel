interface zif_otel_metrics_processor
  public .

  methods on_metric_value_added importing
    meter type ref to zif_otel_meter
    metric type ref to zif_otel_metric
    data_point type ref to zif_otel_data_point.

endinterface.
