class zcl_otel_tracer definition
  public
  final
  create private global friends zcl_otel_trace_controller.

  public section.
    interfaces zif_otel_tracer.
    interfaces zif_otel_has_context.
    methods constructor.


  protected section.
  private section.

    data span_stack type ref to zif_otel_stack.

    methods:
      on_span_end for event span_end of zcl_otel_span
        importing sender stack_depth,
      on_span_event for event span_event of zcl_otel_span
        importing event stack_depth.

    events:
      span_start
        exporting
            value(span) type ref to zif_otel_span
            value(stack_depth) type i ,
      span_end
        exporting
            value(span) type ref to zif_otel_span
            value(stack_depth) type i ,

      span_event
        exporting
            value(span_event) type ref to zif_otel_span_event
            value(stack_depth) type i .

ENDCLASS.



CLASS ZCL_OTEL_TRACER IMPLEMENTATION.


  method constructor.

    me->span_stack = new zcl_otel_stack(  ).

  endmethod.


  method on_span_end.

    set handler on_span_end on_span_event for sender activation ' '.

    me->span_stack->pop(  ).

    raise event span_end exporting span = sender stack_depth = stack_depth + 1.

  endmethod.


  method on_span_event.

    raise event span_event exporting span_event = event  stack_depth = stack_depth + 1.

  endmethod.


  method zif_otel_has_context~context.

    data(last_span) = me->span_stack->last( ).
    check last_span is bound.

*    field-symbols <last_span> type ref to object.
    assign last_span->* to field-symbol(<last_span>).
    check <last_span> is assigned.

    try.
      result = cast #( <last_span> ).
      catch cx_sy_move_cast_error.
    endtry.

  endmethod.


  method zif_otel_tracer~start_span.

    if context is not bound and default_context eq abap_true.
      context = me->zif_otel_has_context~context( ).
    endif.

    data(span) = new zcl_otel_span(
      name    = name
*     start_time = start_time
      context = context
    ).

    set handler on_span_end on_span_event for span.

    result = span.

    me->span_stack->push( ref #( span )  ).

    raise event span_start exporting span = span  stack_depth = stack_depth + 1.

  endmethod.
ENDCLASS.
