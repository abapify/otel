class zcl_otel_tracer_provider definition
  public
  final
  create private
  global friends zcl_otel_trace_api .

  public section.
    interfaces zif_otel_tracer_provider.
  protected section.
  private section.

    types:
      begin of tracers_ts,
        name   type string,
        tracer type ref to zif_otel_tracer,
      end of tracers_ts.

    data tracers type hashed table of tracers_ts with unique key name.

    methods on_span_start
      for event span_start of zcl_otel_tracer
      importing sender
                !span stack_depth.
    methods on_span_end
      for event span_end of zcl_otel_tracer
      importing sender
                !span stack_depth.
    methods on_span_event
      for event span_event of zcl_otel_tracer
      importing
        sender
        span
        !span_event stack_depth.


    events:
      span_start
        exporting
          value(tracer)      type ref to zif_otel_tracer
          value(span)        type ref to zif_otel_span
          value(stack_depth) type i ,
      span_end
        exporting
          value(tracer)      type ref to zif_otel_tracer
          value(span)        type ref to zif_otel_span
          value(stack_depth) type i ,

      span_event
        exporting
          value(tracer)      type ref to zif_otel_tracer
          value(span)        type ref to zif_otel_span
          value(span_event)  type ref to zif_otel_span_event
          value(stack_depth) type i .

endclass.



class zcl_otel_tracer_provider implementation.
  method zif_otel_tracer_provider~get_tracer.

    try.

      data(cache) = ref #( tracers[ name = name ] ).

    catch cx_sy_itab_line_not_found.

      data(tracer) = new zcl_otel_tracer( name = name ).

      set handler on_span_end on_span_event on_span_start for tracer.

      insert value #(
        name = name
        tracer = tracer  ) into table tracers
        reference into cache.

    endtry.

    result = cache->tracer.


  endmethod.

  method on_span_end.

    raise event span_end
      exporting
        tracer      = sender
        span        = span
        stack_depth = stack_depth
      .

  endmethod.

  method on_span_event.

    raise event span_event
      exporting
        tracer      = sender
        span        = span
        span_event  = span_event
        stack_depth = stack_depth
      .

  endmethod.

  method on_span_start.

    raise event span_start
      exporting
        tracer      = sender
        span        = span
        stack_depth = stack_depth
      .

  endmethod.

endclass.
