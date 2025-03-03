"! Loggable Interface
"! Provides a standardized method to log messages.
interface zif_otel_loggable public.

  "! Logs a new record by creating a log entry and emitting it.
  "!
  "! @parameter message    | The message content of the log.
  "! @parameter severity   | The severity level (default: INFO).
  "! @parameter attributes | Optional key-value attributes associated with the log.
  "! @parameter context    | Optional trace and span context for distributed tracing.
  "! @parameter timestamp  | Optional timestamp when the log was created.
  methods log importing
                body             type any
                value(severity)  type zif_otel_severity=>severity_type optional
                attributes       type ref to zif_otel_attribute_map optional
                context          type ref to zif_otel_context optional
                value(timestamp) type timestampl optional.

endinterface.
