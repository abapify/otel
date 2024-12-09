CLASS zcl_otel_metric DEFINITION
  PUBLIC
  ABSTRACT.

  PUBLIC SECTION.
    INTERFACES zif_otel_metric.
    
    METHODS constructor
      IMPORTING
        name    TYPE string
        options TYPE zif_otel_metric=>ts_metric_options OPTIONAL.

  PROTECTED SECTION.
    DATA:
      mv_name        TYPE string,
      mv_unit        TYPE string,
      mv_description TYPE string,
      mv_value_type  TYPE zif_otel_metric=>te_value_type.

ENDCLASS.

CLASS zcl_otel_metric IMPLEMENTATION.

  METHOD constructor.
    mv_name = name.
    IF options IS NOT INITIAL.
      mv_unit = options-unit.
      mv_description = options-description.
      mv_value_type = options-value_type.
    ENDIF.
  ENDMETHOD.

  METHOD zif_otel_metric~set_description.
    mv_description = description.
    self = me.
  ENDMETHOD.

  METHOD zif_otel_metric~set_unit.
    mv_unit = unit.
    self = me.
  ENDMETHOD.

ENDCLASS.
