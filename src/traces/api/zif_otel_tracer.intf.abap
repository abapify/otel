interface zif_otel_tracer
  public .

  interfaces zif_otel_scope.

  "value(CONTEXT) type ZIF_TRACE_SPAN_CONTEXT=>SPAN_CONTEXT_TS optional
  "ATTRIBUTES type ZIF_TRACE_ATTRIBUTES=>ATTRIBUTES_TT optional
  methods start_span
    importing
      !name            type csequence
      value(context)   type ref to zif_otel_context optional
      !options         type zif_otel_span_options=>span_options optional
      !stack_depth     type i default 1
    returning
      value(result)    type ref to zif_otel_span .
endinterface.
