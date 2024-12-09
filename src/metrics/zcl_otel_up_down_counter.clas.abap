CLASS zcl_otel_up_down_counter DEFINITION
  PUBLIC
  INHERITING FROM zcl_otel_metric
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES zif_otel_up_down_counter.

  PRIVATE SECTION.
    DATA mv_value TYPE zif_otel_metric=>tv_value.

ENDCLASS.

CLASS zcl_otel_up_down_counter IMPLEMENTATION.

  METHOD zif_otel_up_down_counter~add.
    mv_value = mv_value + value.
  ENDMETHOD.

ENDCLASS.
