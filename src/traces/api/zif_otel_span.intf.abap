interface ZIF_OTEL_SPAN
  public .


  interfaces ZIF_OTEL_SPAN_CONTEXT .
  interfaces zif_otel_has_attributes.
  aliases attributes for zif_otel_has_attributes~attributes.

  " Span Id
  aliases SPAN_ID
    for ZIF_OTEL_SPAN_CONTEXT~SPAN_ID .
  " Trace id
  aliases TRACE_ID
    for ZIF_OTEL_SPAN_CONTEXT~TRACE_ID .

  types SPAN_STATUS_TYPE type STRING .

  constants:
    begin of span_status,
      unset type span_status_type value 'UNSET',
      error type span_status_type value 'ERROR',
      ok    type span_status_type value 'OK',
    end of span_status .
  data STATUS type SPAN_STATUS_TYPE read-only .
  data NAME type STRING read-only .
  data START_TIME type TIMESTAMPL read-only .
  data END_TIME type TIMESTAMPL read-only .
  data PARENT_SPAN_ID like SPAN_ID read-only .
  data:
    events type table of ref to zif_otel_span_event with empty key read-only .
  data:
    links type table of ref to zif_otel_span_link with empty key read-only .

  methods END
    importing
      value(END_TIME) type TIMESTAMPL optional
      value(STATUS) type SPAN_STATUS_TYPE optional
      stack_depth type i optional .
  " shortcut for end with error
  methods FAIL
    importing
      !REASON type STRING optional
      stack_depth type i optional
      preferred parameter reason.
  methods LOG
    importing
      !NAME type STRING
      stack_depth type i optional.
  methods LINK
    importing
      !CONTEXT type ref to ZIF_OTEL_SPAN_CONTEXT .
endinterface.
