INTERFACE zif_otel_trace_processor
  PUBLIC .

    METHODS on_span_start
        IMPORTING span TYPE REF TO zif_otel_span.

    METHODS on_span_event
        IMPORTING span TYPE REF TO zif_otel_span.

    METHODS on_span_end
        IMPORTING span TYPE REF TO zif_otel_span.

ENDINTERFACE.
