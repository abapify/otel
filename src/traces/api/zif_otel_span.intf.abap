INTERFACE zif_otel_span
  PUBLIC .

  INTERFACEs zif_otel_span_context.

   " Span Id
  aliases SPAN_ID for zif_otel_span_context~span_id.
  " Trace id
  aliases trace_ID for zif_otel_span_context~trace_ID.

  data NAME type STRING read-only .
  data START_TIME type TIMESTAMPL read-only .
  data END_TIME type TIMESTAMPL read-only .
  data PARENT_SPAN_ID like SPAN_ID read-only .

  METHODS end
   importing
      value(END_TIME) type TIMESTAMPL optional.

ENDINTERFACE.
