CLASS zcl_otel_metrics_api DEFINITION
  PUBLIC
  CREATE PRIVATE.

  PUBLIC SECTION.
    INTERFACES zif_otel_metrics_api.
    
    CLASS-METHODS:
      get_instance
        RETURNING
          VALUE(instance) TYPE REF TO zif_otel_metrics_api.

  PRIVATE SECTION.
    CLASS-DATA go_instance TYPE REF TO zcl_otel_metrics_api.
    DATA mo_meter_provider TYPE REF TO zif_otel_meter_provider.

ENDCLASS.

CLASS zcl_otel_metrics_api IMPLEMENTATION.

  METHOD get_instance.
    IF go_instance IS INITIAL.
      go_instance = NEW #( ).
    ENDIF.
    instance = go_instance.
  ENDMETHOD.

  METHOD zif_otel_metrics_api~disable.
    mo_meter_provider = NEW zcl_otel_meter_provider( ).
  ENDMETHOD.

  METHOD zif_otel_metrics_api~get_meter.
    meter = zif_otel_metrics_api~get_meter_provider( )->get_meter( 
      name = name
      version = version
      schema_url = schema_url
      attributes = attributes ).
  ENDMETHOD.

  METHOD zif_otel_metrics_api~get_meter_provider.
    IF mo_meter_provider IS INITIAL.
      mo_meter_provider = NEW zcl_otel_meter_provider( ).
    ENDIF.
    provider = mo_meter_provider.
  ENDMETHOD.

  METHOD zif_otel_metrics_api~set_global_meter_provider.
    mo_meter_provider = provider.
  ENDMETHOD.

  METHOD zif_otel_metrics_api~get_instance.
    instance = get_instance( ).
  ENDMETHOD.

ENDCLASS.
