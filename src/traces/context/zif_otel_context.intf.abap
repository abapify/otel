INTERFACE zif_otel_context
  PUBLIC .

    data parent_context TYPE REF TO zif_otel_context READ-ONLY.
    data root_context type ref to zif_otel_context read-only.

ENDINTERFACE.
