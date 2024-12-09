INTERFACE zif_otel_metric
  PUBLIC.

  TYPES:
    BEGIN OF ENUM te_value_type,
      int,
      double,
    END OF ENUM te_value_type.

  TYPES:
    BEGIN OF ts_metric_options,
      unit        TYPE string,
      description TYPE string,
      value_type  type te_value_type,
    END OF ts_metric_options.

  METHODS:
    set_unit
      IMPORTING
        unit TYPE string
      RETURNING
        VALUE(self) TYPE REF TO zif_otel_metric,

    set_description
      IMPORTING
        description TYPE string
      RETURNING
        VALUE(self) TYPE REF TO zif_otel_metric,


    add_value
        IMPORTING
          value      TYPE f
          attributes TYPE ref to zif_otel_attributes optional
          context    TYPE REF TO zif_otel_context OPTIONAL
          returning value(result) type ref to zif_otel_data_point.


ENDINTERFACE.