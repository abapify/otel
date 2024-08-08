class ZCL_OTEL_TASK_TRACER definition
  public
  final
  create public .

public section.

  interfaces ZIF_OTEL_TASK_TRACER .

  aliases EXECUTE_TASK
    for ZIF_OTEL_TASK_TRACER~EXECUTE_TASK .

  methods CONSTRUCTOR
    importing
      value(TRACER) type ref to ZIF_OTEL_TRACER optional
    raising
      CX_STATIC_CHECK .
  protected section.
private section.

  data TRACER type ref to ZIF_OTEL_TRACER .
ENDCLASS.



CLASS ZCL_OTEL_TASK_TRACER IMPLEMENTATION.


  method constructor.

    if tracer is not bound.
      tracer = zcl_otel_api=>traces( )->get_tracer( ).
    endif.

    me->tracer = tracer.
  endmethod.


  method zif_otel_task_tracer~execute_task.

    try.

        data(trace) = me->tracer.
        data(span_name) = task->span_name( ).
        data(span) = trace->start_span( name = span_name default_context = default_context ).
        task->execute( span = span ).
        span->end( ).
      catch cx_root into data(lo_cx).
        "handle exception
        if span is bound.
          span->fail( lo_cx->get_text( ) ).
        endif.
        raise exception lo_cx.
    endtry.

  endmethod.
ENDCLASS.
