CLASS zcl_otel_tracer DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE global FRIENDS zcl_otel_trace.

  PUBLIC SECTION.
  INTERFACES zif_otel_tracer.
  PROTECTED SECTION.
  PRIVATE SECTION.

  METHODS:
    on_span_end for event span_end of zcl_otel_span
        IMPORTING sender,
    on_span_event for event span_event of zcl_otel_span
        IMPORTING sender.

  EVENTS:
     span_start EXPORTING value(span) type ref to zif_otel_span,
     span_end EXPORTING value(span) type ref to zif_otel_span,
     span_event EXPORTING value(span) type ref to zif_otel_span.

ENDCLASS.



CLASS zcl_otel_tracer IMPLEMENTATION.

  METHOD zif_otel_tracer~start_span.

     data(span) = new zcl_otel_span(
        name       = name
*        start_time = start_time
        context    = context
      ).

      set handler on_span_end on_span_event for span.

      result = span.

      RAISE EVENT span_start EXPORTING span = span.

  ENDMETHOD.

  METHOD on_span_end.

    set handler on_span_end on_span_event for sender ACTIVATION ' '.

    RAISE EVENT span_end EXPORTING span = sender.

  ENDMETHOD.

  METHOD on_span_event.

     raise EVENT span_event EXPORTING span = sender.

  ENDMETHOD.

ENDCLASS.
