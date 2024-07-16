INTERFACE zif_otel_span_context
  PUBLIC .

  INTERFACEs zif_otel_context.

  DATA: trace_id TYPE zif_otel_trace_types=>trace_id READ-ONLY.
  DATA: span_id TYPE zif_otel_trace_types=>span_id READ-ONLY.

ENDINTERFACE.
