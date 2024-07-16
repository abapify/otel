interface zif_otel_span
  public .

  interfaces zif_otel_span_context.

  " Span Id
  aliases span_id for zif_otel_span_context~span_id.
  " Trace id
  aliases trace_id for zif_otel_span_context~trace_id.

  data name type string read-only .
  data start_time type timestampl read-only .
  data end_time type timestampl read-only .
  data parent_span_id like span_id read-only .

  data events type table of ref to zif_otel_span_event with empty key read-only.
  data links type table of ref to zif_otel_span_link with empty key read-only.

  methods end
    importing
      value(end_time) type timestampl optional.

  methods log
    importing name type string.

  methods link
    importing context type ref to zif_otel_span_context.

endinterface.
