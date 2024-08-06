class zcl_otel_task_tracer definition
  public
  final
  create public .

  public section.

    interfaces zif_otel_task_tracer.
    aliases execute_task for zif_otel_task_tracer~execute_task.
    methods constructor importing span_name type string raising cx_static_check.

  protected section.
  private section.
    data span_name type string.
    methods current_context returning value(result) type ref to zif_otel_span_context.
    data tracer type ref to zif_otel_tracer.

endclass.

class zcl_otel_task_tracer implementation.

  method current_context.
    try.
        data(context) = cast zif_otel_has_context( me->tracer ).
        result = cast #( context->context( ) ).
      catch cx_sy_move_cast_error.
    endtry.
  endmethod.


  method constructor.
    me->span_name = span_name.
    me->tracer = zcl_otel_api=>traces( )->get_tracer( ).
  endmethod.

  method zif_otel_task_tracer~execute_task.

    try.

        data(trace) = me->tracer.
        data(span) = trace->start_span( name = me->span_name context = current_context( ) ).
        task->execute( span = span ).
        span->end( ).
      catch cx_root into data(lo_cx).
        "handle exception
        if span is bound.
          span->fail(  ).
        endif.
        raise exception lo_cx.
    endtry.

  endmethod.

endclass.
