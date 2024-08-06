class zcl_otel_task_tracer definition
  public
  final
  create public .

  public section.

    interfaces zif_otel_task_tracer.
    aliases execute_task for zif_otel_task_tracer~execute_task.
    methods constructor importing span_name type string.
  protected section.
  private section.
    data span_name type string.
ENDCLASS.



CLASS ZCL_OTEL_TASK_TRACER IMPLEMENTATION.


  method constructor.
    me->span_name = span_name.
  endmethod.


  method zif_otel_task_tracer~execute_task.
    try.
        data(trace) = zcl_otel_api=>traces( )->get_tracer( ).
        data(span) = trace->start_span( me->span_name ).
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
ENDCLASS.
