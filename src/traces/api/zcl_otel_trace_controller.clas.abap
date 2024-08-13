class ZCL_OTEL_TRACE_CONTROLLER definition
  public
  final
  create private

  global friends ZCL_OTEL_TRACE .

public section.

  interfaces ZIF_OTEL_EXPORTER .
  interfaces ZIF_OTEL_TRACE_API .
protected section.
private section.

  data:
    processors type table of ref to zif_otel_trace_processor with empty key .
  data:
    exporters type table of ref to zif_otel_exporter with empty key .
  data DEFAULT_TRACER type ref to ZIF_OTEL_TRACER .

  methods ON_SPAN_START
    for event SPAN_START of ZCL_OTEL_TRACER
    importing
      !SPAN stack_depth.
  methods ON_SPAN_END
    for event SPAN_END of ZCL_OTEL_TRACER
    importing
      !SPAN stack_depth.
  methods ON_SPAN_EVENT
    for event SPAN_EVENT of ZCL_OTEL_TRACER
    importing
      !SPAN_EVENT stack_depth.
ENDCLASS.



CLASS ZCL_OTEL_TRACE_CONTROLLER IMPLEMENTATION.


  method on_span_end.
    loop at processors into data(processor).
      processor->on_span_end( span = span stack_depth = stack_depth + 1 ).
    endloop.
  endmethod.


  method on_span_event.
    loop at processors into data(processor).
      processor->on_span_event( event = span_event stack_depth = stack_depth + 1 ).
    endloop.
  endmethod.


  method on_span_start.
    loop at processors into data(processor).
      processor->on_span_start( span = span stack_depth = stack_depth + 1 ).
    endloop.
  endmethod.


  method zif_otel_exporter~export.
    loop at exporters into data(exporter).
      " self-cleaning
      if exporter is not bound.
        delete exporters index sy-index.
        continue.
      endif.
      exporter->export(  ).
    endloop.
  endmethod.


  method zif_otel_trace_api~get_tracer.

    if new eq abap_false and me->default_tracer is bound.
      result = me->default_tracer.
      return.
    endif.

    data(tracer) = new zcl_otel_tracer( ).
    set handler
        on_span_start
        on_span_event
        on_span_end for tracer.
    result = tracer.

    if me->default_tracer is not bound.
      me->default_tracer = tracer.
    endif.
  endmethod.


  method zif_otel_trace_api~use.
    append processor to processors.
    try.
        data(exporter) = cast zif_otel_exporter( processor ).
        append exporter to exporters.
      catch cx_sy_move_cast_error.
    endtry.
  endmethod.
ENDCLASS.
