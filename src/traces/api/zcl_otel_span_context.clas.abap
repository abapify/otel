class zcl_otel_span_context definition
inheriting from zcl_otel_context
  final
  public

  create public .

  public section.
  interfaces zif_otel_span_context.

  aliases trace_id for zif_otel_span_context~trace_id.
  aliases span_id for zif_otel_span_context~span_id.

  methods constructor
    importing
        context type ref to zif_otel_context
        span    type ref to zif_otel_span.

  protected section.
  private section.

endclass.



class zcl_otel_span_context implementation.
  METHOD constructor.
    super->constructor( context = context ).
    if span is bound.
        me->trace_id = span->trace_id.
        me->span_id = span->span_id.
    endif.
  ENDMETHOD.

  method zif_otel_span_context~get_span_context.

    result = value #(
        trace_id = me->zif_otel_span_context~trace_id
        span_id = me->zif_otel_span_context~span_id
    ).

  endmethod.
endclass.
