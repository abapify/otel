"! OpenTelemetry Logger Interface
"! This interface represents a logger that emits log records.
interface zif_otel_logger public.

  interfaces zif_otel_loggable.
  aliases log for zif_otel_loggable~log.

  "! Logger name for identification.
  data name type string read-only.

  "! Emits an already created log record.
  "!
  "! @parameter record | The log record instance to be emitted.
  methods emit importing record type ref to zif_otel_log_record.

endinterface.
