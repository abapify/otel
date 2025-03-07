interface zif_otel_logs_collector
  public .

  methods add_log
    importing logger type ref to zif_otel_logger
    log_record type ref to zif_otel_log_record.

endinterface.
