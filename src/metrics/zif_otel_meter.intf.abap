INTERFACE zif_otel_meter
  PUBLIC.

  data name type string read-only.
  interfaces zif_otel_scope.

  METHODS:
    create_counter
      IMPORTING
        name       TYPE string
        options    TYPE zif_otel_metric=>ts_metric_options OPTIONAL
      RETURNING
        VALUE(counter) TYPE REF TO zif_otel_counter,

    create_up_down_counter
      IMPORTING
        name       TYPE string
        options    TYPE zif_otel_metric=>ts_metric_options OPTIONAL
      RETURNING
        VALUE(counter) TYPE REF TO zif_otel_up_down_counter,

    create_gauge
      IMPORTING
        name       TYPE string
        options    TYPE zif_otel_metric=>ts_metric_options OPTIONAL
      RETURNING
        VALUE(gauge) TYPE REF TO zif_otel_gauge,

    create_histogram
      IMPORTING
        name       TYPE string
        options    TYPE zif_otel_metric=>ts_metric_options OPTIONAL
      RETURNING
        VALUE(histogram) TYPE REF TO zif_otel_histogram.

ENDINTERFACE.
