INTERFACE zif_otel_histogram
  PUBLIC.

  INTERFACES zif_otel_metric.

  METHODS:
    "! Records a value with attributes
    "! @parameter value | The measurement value
    "! @parameter attributes | Attributes to associate with the value
    "! @parameter context | The context for this measurement
    record
      IMPORTING
        value      TYPE f
        attributes TYPE any OPTIONAL
        context    TYPE REF TO zif_otel_context OPTIONAL
        returning value(result) type ref to zif_otel_data_point..

ENDINTERFACE.
