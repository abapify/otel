INTERFACE zif_otel_metrics_api
  PUBLIC.

  METHODS:
*    "! Disable metrics operations
*    disable,

    "! Gets or creates a Meter
    "! @parameter name | The name of the meter
    get_meter
      IMPORTING
        name        TYPE string
        " version     TYPE string OPTIONAL
        " schema_url  TYPE string OPTIONAL
        " attributes  TYPE any OPTIONAL
      RETURNING
        VALUE(meter) TYPE REF TO zif_otel_meter,

    "! Gets the meter provider
    get_meter_provider
      RETURNING
        VALUE(provider) TYPE REF TO zif_otel_meter_provider.
*
*    "! Sets the global meter provider
*    "! @parameter provider | The meter provider to be set as global
*    set_global_meter_provider
*      IMPORTING
*        provider TYPE REF TO zif_otel_meter_provider.

ENDINTERFACE.
