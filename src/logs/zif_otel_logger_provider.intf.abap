"! OpenTelemetry Logger Provider Interface
"! Manages and provides instances of loggers based on their names.
INTERFACE zif_otel_logger_provider PUBLIC.

  "! Retrieves a logger instance by name, creating a new one if necessary.
  "!
  "! @parameter name   | The name of the logger.
  "! @parameter result | The corresponding logger instance.
  METHODS get_logger IMPORTING name TYPE string optional
                      RETURNING VALUE(result) TYPE REF TO zif_otel_logger.

ENDINTERFACE.
