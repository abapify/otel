INTERFACE zif_otel_metrics_api
  PUBLIC.

  METHODS:
    "! Disable metrics operations
    disable,

    "! Gets or creates a Meter
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
        VALUE(meter) TYPE REF TO zif_otel_meter,

    "! Gets the meter provider
    "! @returning value | The meter provider instance
    get_meter_provider
      RETURNING
        VALUE(provider) TYPE REF TO zif_otel_meter_provider,

    "! Sets the global meter provider
    "! @parameter provider | The meter provider to be set as global
    set_global_meter_provider
      IMPORTING
        provider TYPE REF TO zif_otel_meter_provider,

    "! Gets the metrics API instance
    "! @returning value | The metrics API singleton instance
    get_instance
      RETURNING
        VALUE(instance) TYPE REF TO zif_otel_metrics_api.

ENDINTERFACE.