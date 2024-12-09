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

  types attributes_type type zif_otel_attribute_map=>entries_tt.
  types context_type type ref to zif_otel_context.
  types value_type type f.


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

    set_double
      returning value(self) type ref to zif_otel_metric,


    add_value
        IMPORTING
          value      TYPE value_type
          attributes TYPE attributes_type optional
          context    TYPE context_type OPTIONAL.


ENDINTERFACE.
