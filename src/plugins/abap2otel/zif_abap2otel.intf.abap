interface zif_abap2otel
  public .

  interfaces zif_abap2otel_span.
  interfaces zif_abap2otel_metric.

  types:
    begin of logs_ts,
      to_do type abap_bool,
    end of logs_ts,

    begin of message_ts,
      spans   type table of zif_abap2otel_span~span_ts    with empty key,
      logs    type table of logs_ts    with empty key,
      metrics type table of zif_abap2otel_metric~metric_ts with empty key,
    end of message_ts.

endinterface.
