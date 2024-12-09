INTERFACE zif_otel_up_down_counter
  PUBLIC.

  INTERFACES zif_otel_metric.

  METHODS:
    add
      IMPORTING
        value      TYPE f
        attributes TYPE any OPTIONAL
        context    TYPE REF TO zif_otel_context OPTIONAL
        returning value(result) type ref to zif_otel_data_point.

ENDINTERFACE.