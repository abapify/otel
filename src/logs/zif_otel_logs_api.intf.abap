interface zif_otel_logs_api
  public .

    methods get_logger_provider returning value(result) type ref to zif_otel_logger_provider.

    methods get_logger
        importing name type string optional
        returning value(result) type ref to zif_otel_logger.

endinterface.
