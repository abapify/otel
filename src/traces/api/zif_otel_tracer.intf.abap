INTERFACE zif_otel_tracer
  PUBLIC .

    methods START_SPAN
        importing
          !NAME type csequence
          context TYPE REF TO zif_otel_context OPTIONAL
          "value(CONTEXT) type ZIF_TRACE_SPAN_CONTEXT=>SPAN_CONTEXT_TS optional
          "ATTRIBUTES type ZIF_TRACE_ATTRIBUTES=>ATTRIBUTES_TT optional
        returning
          value(RESULT) type ref to ZIF_OTEL_SPAN .



ENDINTERFACE.
