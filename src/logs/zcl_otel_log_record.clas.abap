"! OpenTelemetry Log Record Implementation
"! Represents a structured log entry following OpenTelemetry standards.
CLASS zcl_otel_log_record DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    " Implements the OpenTelemetry log record interface.
    INTERFACES zif_otel_log_record.

    "! Constructor to initialize the log record.
    "!
    "! @parameter severity   | The severity level of the log.
    "! @parameter body       | The message content of the log.
    "! @parameter attributes | Optional key-value attributes associated with the log.
    "! @parameter context    | Optional trace and span context for distributed tracing.
    "! @parameter timestamp  | The timestamp when the log was created.
    METHODS constructor IMPORTING
      severity   TYPE zif_otel_severity=>severity_type
      body       TYPE REF TO data
      attributes TYPE REF TO zif_otel_attribute_map OPTIONAL
      context    TYPE REF TO zif_otel_context OPTIONAL
      timestamp  TYPE timestampl OPTIONAL.

  PRIVATE SECTION.

    " Interface aliases for read-only access to attributes.
    ALIASES severity   FOR zif_otel_log_record~severity.
    ALIASES body       FOR zif_otel_log_record~body.
    ALIASES attributes FOR zif_otel_log_record~attributes.
    ALIASES context    FOR zif_otel_log_record~context.
    ALIASES timestamp  FOR zif_otel_log_record~timestamp.

ENDCLASS.

CLASS zcl_otel_log_record IMPLEMENTATION.

  METHOD constructor.

    " Assign values to read-only attributes.
    me->severity = severity.
    me->body = body.
    me->attributes = attributes.
    me->context = context.

    " Set timestamp if not provided.
    IF timestamp IS INITIAL.
      GET TIME STAMP FIELD me->timestamp.
    ELSE.
      me->timestamp = timestamp.
    ENDIF.

  ENDMETHOD.

ENDCLASS.


