"! OpenTelemetry Logs Processor Interface
"! Listens for log events and processes them.
interface zif_otel_logs_processor public.

  "! Processes a log record when it is emitted.
  "!
  "! @parameter logger | The logger that emitted the log.
  "! @parameter record | The log record instance.
  methods on_log_record_added importing
    logger type ref to zif_otel_logger
    record type ref to zif_otel_log_record.

endinterface.
