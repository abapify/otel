CLASS zcl_otel_gauge DEFINITION
  PUBLIC
  INHERITING FROM zcl_otel_metric
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES zif_otel_gauge.

  PRIVATE SECTION.
    DATA mv_value TYPE zif_otel_metric=>tv_value.

ENDCLASS.

CLASS zcl_otel_gauge IMPLEMENTATION.

  METHOD zif_otel_gauge~record.
    mv_value = value.
  ENDMETHOD.

ENDCLASS.
