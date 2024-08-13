interface ZIF_OTEL_TRACER
  public .


          "value(CONTEXT) type ZIF_TRACE_SPAN_CONTEXT=>SPAN_CONTEXT_TS optional
          "ATTRIBUTES type ZIF_TRACE_ATTRIBUTES=>ATTRIBUTES_TT optional
  methods START_SPAN
    importing
      !NAME type CSEQUENCE
      value(CONTEXT) type ref to ZIF_OTEL_CONTEXT optional
      !DEFAULT_CONTEXT type ABAP_BOOL optional
      !STACK_DEPTH type I default 1
    returning
      value(RESULT) type ref to ZIF_OTEL_SPAN .
endinterface.
