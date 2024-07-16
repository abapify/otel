INTERFACE zif_otel_trace_provider
  PUBLIC .

    METHODS use IMPORTING processor TYPE REF TO zif_otel_trace_processor.

ENDINTERFACE.
