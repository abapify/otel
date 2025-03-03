interface zif_otel_tracer
  public .


  "value(CONTEXT) type ZIF_TRACE_SPAN_CONTEXT=>SPAN_CONTEXT_TS optional
  "ATTRIBUTES type ZIF_TRACE_ATTRIBUTES=>ATTRIBUTES_TT optional
  methods start_span
    importing
      !name            type csequence
      value(context)   type ref to zif_otel_span_context optional
      !default_context type abap_bool optional
      !stack_depth     type i default 1
    returning
      value(result)    type ref to zif_otel_span .
endinterface.
