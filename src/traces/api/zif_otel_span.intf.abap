interface zif_otel_span
  public .

  interfaces zif_otel_span_context.

  " Span Id
  aliases span_id for zif_otel_span_context~span_id.
  " Trace id
  aliases trace_id for zif_otel_span_context~trace_id.

  types: span_status_type type string.

  constants:
    begin of span_status,
      unset type span_status_type value 'UNSET',
      error type span_status_type value 'ERROR',
      ok    type span_status_type value 'OK',
    end of span_status.

  data status type span_status_type read-only.
  data name type string read-only .
  data start_time type timestampl read-only .
  data end_time type timestampl read-only .
  data parent_span_id like span_id read-only .

  data events type table of ref to zif_otel_span_event with empty key read-only.
  data links type table of ref to zif_otel_span_link with empty key read-only.

  methods end
    importing
      value(end_time) type timestampl optional
      value(status) type span_status_type optional.

  " shortcut for end with error
  methods fail.

  methods log
    importing name type string.

  methods link
    importing context type ref to zif_otel_span_context.

endinterface.
