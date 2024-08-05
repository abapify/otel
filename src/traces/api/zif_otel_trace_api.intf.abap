INTERFACE zif_otel_trace_api
  PUBLIC .

    " get tracer
    methods get_tracer returning value(result) type ref to zif_otel_tracer.

    " use processor
    METHODS use IMPORTING processor TYPE REF TO zif_otel_trace_processor.


ENDINTERFACE.
