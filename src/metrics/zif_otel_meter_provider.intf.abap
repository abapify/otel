INTERFACE zif_otel_meter_provider
  PUBLIC.

  METHODS:
    "! Gets or creates a new Meter
    "! @parameter name | The name of the meter
    "! @parameter version | The version of the meter
    "! @parameter schema_url | The schema URL of the meter
    "! @parameter attributes | The attributes of the meter
    "! @returning value | The meter instance
    get_meter
      IMPORTING
        name        TYPE string
        " version     TYPE string OPTIONAL
        " schema_url  TYPE string OPTIONAL
        " attributes  TYPE any OPTIONAL
      RETURNING
        VALUE(meter) TYPE REF TO zif_otel_meter.

ENDINTERFACE.
