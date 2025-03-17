INTERFACE zif_otel_span_context
  PUBLIC .

  DATA: trace_id TYPE zif_otel_trace_types=>trace_id READ-ONLY.
  DATA: span_id TYPE zif_otel_trace_types=>span_id READ-ONLY.

  types:
      begin of span_context_ts,
          trace_id like trace_id,
          span_id like span_id,
      end of span_context_ts.

  methods get_span_context returning value(result) type span_context_ts.


ENDINTERFACE.
