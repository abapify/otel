*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
CLASS lcl_trace_processor DEFINITION.
  PUBLIC SECTION.
    INTERFACES zif_otel_trace_processor.
    INTERFACES zif_otel_trace_provider.
  PRIVATE SECTION.
    DATA processors TYPE TABLE OF REF TO zif_otel_trace_processor WITH EMPTY KEY.
ENDCLASS.

CLASS lcl_trace_processor IMPLEMENTATION.
  METHOD zif_otel_trace_provider~use.
    APPEND processor TO processors.
  ENDMETHOD.
  METHOD zif_otel_trace_processor~on_span_start.
    LOOP AT processors INTO DATA(processor).
      processor->on_span_start( span = span ).
    ENDLOOP.
  ENDMETHOD.
  METHOD zif_otel_trace_processor~on_span_event.
    LOOP AT processors INTO DATA(processor).
      processor->on_span_event( span = span ).
    ENDLOOP.
  ENDMETHOD.
  METHOD zif_otel_trace_processor~on_span_end.
    LOOP AT processors INTO DATA(processor).
      processor->on_span_end( span = span ).
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
