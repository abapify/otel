class zcl_otel_task_tracer definition
  public
  final
  create public .

  public section.

    interfaces zif_otel_task_tracer.
    aliases execute_task for zif_otel_task_tracer~execute_task.
    methods constructor
      importing
                span_name     type string
                value(tracer) type ref to zif_otel_tracer optional
      raising   cx_static_check
      .

  protected section.
  private section.
    data span_name type string.
    methods current_context returning value(result) type ref to zif_otel_span_context.
    data tracer type ref to zif_otel_tracer.
    data context type ref to zif_otel_has_context.

endclass.

class zcl_otel_task_tracer implementation.

  method current_context.
    result = cast #( context->context( ) ).
  endmethod.

  method constructor.
    me->span_name = span_name.

    if tracer is not bound.
      tracer = zcl_otel_api=>traces( )->get_tracer( ).
    endif.

    me->tracer = tracer.
    me->context = cast #( tracer ).
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
