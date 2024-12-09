CLASS zcl_otel_meter_provider DEFINITION
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES zif_otel_meter_provider.

  PRIVATE SECTION.
    TYPES: BEGIN OF ts_meter_cache,
             name   TYPE string,
             meter  TYPE REF TO zif_otel_meter,
           END OF ts_meter_cache.
    
    DATA mt_meters TYPE HASHED TABLE OF ts_meter_cache WITH UNIQUE KEY name.

ENDCLASS.

CLASS zcl_otel_meter_provider IMPLEMENTATION.

  METHOD zif_otel_meter_provider~get_meter.
    READ TABLE mt_meters WITH KEY name = name INTO DATA(ls_meter).
    IF sy-subrc = 0.
      meter = ls_meter-meter.
      RETURN.
    ENDIF.

    meter = NEW zcl_otel_meter( ).
    INSERT VALUE #( name = name
                   meter = meter ) INTO TABLE mt_meters.
  ENDMETHOD.

ENDCLASS.
