INTERFACE zif_otel_counter
  PUBLIC.

  INTERFACES zif_otel_metric.

  METHODS:
    add
      IMPORTING
        value      TYPE f
        attributes TYPE any OPTIONAL
        context    TYPE REF TO zif_otel_context OPTIONAL.

ENDINTERFACE.