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
        importing sender,
      on_span_event for event span_event of zcl_otel_span
        importing event.

    events:
      span_start exporting value(span) type ref to zif_otel_span,
      span_end exporting value(span) type ref to zif_otel_span,
      span_event exporting value(span_event) type ref to zif_otel_span_event.

endclass.

class zcl_otel_tracer implementation.

  method zif_otel_tracer~start_span.

    data(span) = new zcl_otel_span(
      name    = name
*     start_time = start_time
      context = context
    ).

    set handler on_span_end on_span_event for span.

    result = span.

    me->span_stack->push( ref #( span )  ).

    raise event span_start exporting span = span.

  endmethod.

  method on_span_end.

    set handler on_span_end on_span_event for sender activation ' '.

    me->span_stack->pop(  ).

    raise event span_end exporting span = sender.

  endmethod.

  method on_span_event.

    raise event span_event exporting span_event = event.

  endmethod.

  method constructor.

    me->span_stack = new zcl_otel_stack(  ).

  endmethod.

  method zif_otel_has_context~context.

    types span_ref type ref to zif_otel_span.

    try.
        data(last_span) = cast span_ref( me->span_stack->last( ) ).
        result = last_span->*.
      catch cx_sy_move_cast_error.
    endtry.

  endmethod.

endclass.
