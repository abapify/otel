class zcl_otel_task_tracer definition
  public
  final
  create public .

  public section.

    interfaces zif_otel_task_tracer.
    aliases execute_task for zif_otel_task_tracer~execute_task.
    methods constructor importing span_name type string.
    class-methods api returning value(result) type ref to zif_otel_trace_api
    raising cx_static_check.
    class-methods stack_processor  returning value(result) type ref to zif_otel_trace_processor.

  protected section.
  private section.
    data span_name type string.
    methods current_context returning value(result) type ref to zif_otel_span_context.

endclass.

class zcl_otel_task_tracer implementation.

  method current_context.
    data(stack_processor) = cast lcl_span_stack_processor( stack_processor(   ) ).
    result = stack_processor->current_context( ).
  endmethod.

  method stack_processor.
    statics stack_processor type ref to lcl_span_stack_processor.
    if stack_processor is not bound.
       stack_processor = new #(  ).
    endif.
    result = stack_processor.
  endmethod.

  method api.
    statics api like result.
    if api is not bound.
        api = zcl_otel_api=>traces( ).
        api->use( stack_processor( ) ).
    endif.
    result = api.
  endmethod.

  method constructor.
    me->span_name = span_name.
  endmethod.

  method zif_otel_task_tracer~execute_task.

    try.

        data(trace) = zcl_otel_api=>traces( )->get_tracer( ).
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
