CLASS zcl_otel_meter DEFINITION
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES zif_otel_meter.

ENDCLASS.

CLASS zcl_otel_meter IMPLEMENTATION.

  METHOD zif_otel_meter~create_counter.
    counter = NEW zcl_otel_counter( name = name
                                   options = options ).
  ENDMETHOD.

  METHOD zif_otel_meter~create_up_down_counter.
    counter = NEW zcl_otel_up_down_counter( name = name
                                           options = options ).
  ENDMETHOD.

  METHOD zif_otel_meter~create_gauge.
    gauge = NEW zcl_otel_gauge( name = name
                               options = options ).
  ENDMETHOD.

  METHOD zif_otel_meter~create_histogram.
    histogram = NEW zcl_otel_histogram( name = name
                                      options = options ).
  ENDMETHOD.

ENDCLASS.
