*&---------------------------------------------------------------------*
*& Report  ZTEST_OTEL_COMPARE
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
report ztest_otel_compare.

parameters x_init as checkbox.
parameters x_rtm as checkbox.
parameters x_db as checkbox.
parameters p_times type i.

class app definition.
  public section.
    interfaces ZIF_OTEL_TRACER.
    methods start.
    methods constructor.
  private section.
    methods run importing index type i.
    aliases trace for ZIF_OTEL_TRACER~start_span.
    data tracer type ref to zif_otel_tracer.
endclass.

start-of-selection.

  new app( )->start( ).
*  rollback work.

class app implementation.
  method constructor.

    if x_init eq abap_true.
      delete from zotel_spans.
      commit work.
    endif.

    data(api) = zcl_otel_trace=>api.

    if x_rtm eq abap_true.
      api->use( new zcl_otel_trace_processor_rtm( ) ).
    endif.

    if x_db eq abap_true.
      api->use( new zcl_otel_trace_processor_db( ) ).
    endif.

    me->tracer = api->get_tracer( ).

  endmethod.
  method start.
    data(trace) = trace( 'Comparing OTel processors' ).
    do p_times times.
      run( sy-index ).
    enddo.
    trace->end( ).
  endmethod.
  method run.
    data(trace) = trace( |Task iteration { index }| ).
    trace->end( ).
  endmethod.
  method ZIF_OTEL_TRACER~start_span.
    result = tracer->start_span(
             name            = name
             stack_depth     = stack_depth + 1
         ).
  endmethod.
endclass.
