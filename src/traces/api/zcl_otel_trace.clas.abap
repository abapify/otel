CLASS zcl_otel_trace DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE .

  PUBLIC SECTION.
    INTERFACES zif_otel_trace_api.
    CLASS-DATA api TYPE REF TO zif_otel_trace_api READ-ONLY.
    CLASS-METHODS: class_constructor.

  PROTECTED SECTION.
  PRIVATE SECTION.

    METHODS constructor.

    DATA delegate_processor TYPE REF TO zif_otel_trace_processor.
    DATA delegate_provider TYPE REF TO zif_otel_trace_provider.


    METHODS:
      on_span_start FOR EVENT span_start OF zcl_otel_tracer
        IMPORTING span,
      on_span_end FOR EVENT span_end OF zcl_otel_tracer
        IMPORTING span,
      on_span_event FOR EVENT span_event OF zcl_otel_tracer
        IMPORTING span.

ENDCLASS.

CLASS zcl_otel_trace IMPLEMENTATION.

  METHOD constructor.
    DATA(lo_delegate) = NEW lcl_trace_processor(  ).
    me->delegate_processor = lo_delegate.
    me->delegate_provider = lo_delegate.
  ENDMETHOD.

  METHOD class_constructor.

    api = NEW zcl_otel_trace( ).

  ENDMETHOD.

  METHOD zif_otel_trace_api~get_tracer.

    DATA(tracer) = NEW zcl_otel_tracer(  ).

    SET HANDLER
        on_span_start
        on_span_event
        on_span_end FOR tracer.

    result = tracer.

  ENDMETHOD.

  METHOD on_span_end.
    delegate_processor->on_span_end( span = span ).
  ENDMETHOD.

  METHOD on_span_event.
    delegate_processor->on_span_event( span = span ).
  ENDMETHOD.

  METHOD on_span_start.
    delegate_processor->on_span_start( span = span ).
  ENDMETHOD.

  METHOD zif_otel_trace_provider~use.
    delegate_provider->use( processor ).
  ENDMETHOD.

ENDCLASS.
