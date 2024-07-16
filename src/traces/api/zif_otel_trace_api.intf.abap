INTERFACE zif_otel_trace_api
  PUBLIC .

    INTERFACES zif_otel_trace_provider.

    METHODS get_tracer IMPORTING name TYPE string OPTIONAL RETURNING VALUE(result) TYPE REF TO zif_otel_tracer.

    ALIASES USE FOR zif_otel_trace_provider~use.

ENDINTERFACE.
