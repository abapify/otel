INTERFACE zif_otel_meter_provider
  PUBLIC.

  METHODS:
    "! Gets or creates a new Meter
    "! @parameter name | The name of the meter
    get_meter
      IMPORTING
        name        TYPE string
        " version     TYPE string OPTIONAL
        " schema_url  TYPE string OPTIONAL
        " attributes  TYPE any OPTIONAL
      RETURNING
        VALUE(meter) TYPE REF TO zif_otel_meter.

ENDINTERFACE.
