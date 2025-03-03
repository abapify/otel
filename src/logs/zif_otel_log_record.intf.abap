"! OpenTelemetry Log Record Interface
"! Represents a structured log entry following OpenTelemetry standards.
INTERFACE zif_otel_log_record PUBLIC.

  "! Severity level of the log (TRACE, DEBUG, INFO, WARN, ERROR, FATAL).
  DATA severity TYPE zif_otel_severity=>severity_type READ-ONLY.

  "! Log message body (stored as a reference for flexibility).
  DATA body TYPE REF TO data READ-ONLY.

  "! Structured key-value attributes associated with the log.
  DATA attributes TYPE REF TO zif_otel_attribute_map READ-ONLY.

  "! Context information (trace ID, span ID) for distributed tracing.
  DATA context TYPE REF TO zif_otel_context READ-ONLY.

  "! Timestamp when the log was created (RFC 3339 format).
  DATA timestamp TYPE timestampl READ-ONLY.

ENDINTERFACE.
