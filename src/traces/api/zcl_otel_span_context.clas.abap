class ZCL_OTEL_SPAN_CONTEXT definition
  public
  inheriting from ZCL_OTEL_CONTEXT

  create public .

public section.

  interfaces ZIF_OTEL_SPAN_CONTEXT .

  aliases SPAN_ID
    for ZIF_OTEL_SPAN_CONTEXT~SPAN_ID .
  aliases TRACE_ID
    for ZIF_OTEL_SPAN_CONTEXT~TRACE_ID .

  methods CONSTRUCTOR
    importing
      !CONTEXT type ref to ZIF_OTEL_CONTEXT optional
      !TRACE_ID like TRACE_ID optional
      !SPAN_ID like SPAN_ID optional.
protected section.
  private section.

ENDCLASS.



CLASS ZCL_OTEL_SPAN_CONTEXT IMPLEMENTATION.


  method constructor.
    super->constructor( context = context ).
    me->trace_id = trace_id.
    me->span_id = span_id.

  endmethod.


  method zif_otel_span_context~get_span_context.

    result = value #(
        trace_id = me->zif_otel_span_context~trace_id
        span_id = me->zif_otel_span_context~span_id
    ).

  endmethod.
ENDCLASS.
