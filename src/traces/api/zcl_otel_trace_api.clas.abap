class zcl_otel_trace_api definition
  public
  final
  create private
  global friends zcl_otel_api_manager.

  public section.

    interfaces zif_otel_trace_api_manager.

  protected section.
  private section.

    data:
      processors type table of ref to zif_otel_trace_processor with empty key ,
      tracer_provider type ref to zif_otel_tracer_provider.

    methods on_span_start
      for event span_start of zcl_otel_tracer_provider
      importing tracer
                !span stack_depth.
    methods on_span_end
      for event span_end of zcl_otel_tracer_provider
      importing tracer
                !span stack_depth.
    methods on_span_event
      for event span_event of zcl_otel_tracer_provider
      importing
        tracer
        span
        !span_event stack_depth.
endclass.



class zcl_otel_trace_api implementation.



  method on_span_end.
    loop at processors into data(processor).
      processor->on_span_end( tracer = tracer span = span stack_depth = stack_depth + 1 ).
    endloop.
  endmethod.


  method on_span_event.
    loop at processors into data(processor).
      processor->on_span_event( tracer = tracer span = span event = span_event stack_depth = stack_depth + 1 ).
    endloop.
  endmethod.


  method on_span_start.
    loop at processors into data(processor).
      processor->on_span_start( tracer = tracer span = span stack_depth = stack_depth + 1 ).
    endloop.
  endmethod.

  method zif_otel_trace_api_manager~use.
    append processor to processors.
  endmethod.


  method zif_otel_trace_api~get_tracer.
    result = me->zif_otel_trace_api~get_tracer_provider( )->get_tracer(  name ).
  endmethod.

  method zif_otel_trace_api~get_tracer_provider.

    if me->tracer_provider is not bound.

        data(tracer_provider) = new zcl_otel_tracer_provider( ).

        set handler on_span_start on_span_event on_span_end for tracer_provider.

        me->tracer_provider = tracer_provider.

    endif.

    result = me->tracer_provider.

  endmethod.

endclass.
