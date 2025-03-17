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
        context  type ref to zif_otel_context optional
        trace_id like trace_id
        span_id  like span_id.

  protected section.
  private section.

endclass.



class zcl_otel_span_context implementation.


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


endclass.
