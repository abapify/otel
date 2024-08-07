interface zif_abap2otel
  public .
  types:
    span_ts type zif_otel_span_serializable=>span_ts,
    begin of logs_ts,
      to_do type abap_bool,
    end of logs_ts,
    begin of metrics_ts,
      to_do type abap_bool,
    end of metrics_ts,
    begin of message_ts,
      spans   type table of span_ts    with empty key,
      logs    type table of logs_ts    with empty key,
      metrics type table of metrics_ts with empty key,
    end of message_ts.

endinterface.
