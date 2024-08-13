class zcl_otel_span_context definition
inheriting from zcl_otel_context
  public
  final
  create public .

  public section.
  interfaces zif_otel_span_context.

  aliases trace_id for zif_otel_span_context~trace_id.
  aliases span_id for zif_otel_span_context~span_id.

  methods constructor
    importing
        trace_id like trace_id
        span_id like span_id.

  protected section.
  private section.

endclass.



class zcl_otel_span_context implementation.
  METHOD constructor.
    super->constructor( ).
    me->trace_id = trace_id.
    me->span_id = span_id.
  ENDMETHOD.

  METHOD zif_otel_span_context~get_context.
    result = value #(  trace_id = trace_id span_id = span_id ).
  ENDMETHOD.

endclass.
