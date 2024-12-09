CLASS zcl_otel_counter DEFINITION
  PUBLIC
  INHERITING FROM zcl_otel_metric
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES zif_otel_counter.

  PRIVATE SECTION.
    DATA mv_value TYPE zif_otel_metric=>tv_value.

ENDCLASS.

CLASS zcl_otel_counter IMPLEMENTATION.

  METHOD zif_otel_counter~add.
    IF value < 0.
      RAISE EXCEPTION TYPE cx_parameter_invalid.
    ENDIF.

    mv_value = mv_value + value.
  ENDMETHOD.

ENDCLASS.
