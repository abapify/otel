*"* use this source file for your ABAP unit test classes
class ltcl_main definition inheriting from zcl_assert
    final for testing
  duration short
  risk level harmless.

  private section.
    methods:
      simple_run for testing raising cx_static_check.
endclass.

class lcl_noop_processor definition for testing.
  public section.
    interfaces zif_otel_trace_processor.
    data:
      begin of counters read-only,
        span_start type i,
        span_event type i,
        span_end   type i,
      end of counters.
  private section.
    methods count importing counter type ref to i.
endclass.

class lcl_noop_processor implementation.
  method zif_otel_trace_processor~on_span_end.
    count( ref #( counters-span_end ) ).
  endmethod.
  method zif_otel_trace_processor~on_span_event.
    count( ref #( counters-span_event ) ).
  endmethod.
  method zif_otel_trace_processor~on_span_start.
    count( ref #( counters-span_start ) ).
  endmethod.
  method count.
    counter->* = counter->* + 1.
  endmethod.

endclass.

class ltcl_main implementation.

  method simple_run.

    data(trace) = zcl_otel_trace=>api->get_tracer( ).
    data(processor) = new lcl_noop_processor( ).

    assert( trace )->bound( ).

    " Start root span
    data(span_name) = 'Root span'.
    data(span) = trace->start_span( span_name ).
    assert( span )->bound( ).
    assert( span->start_time )->not_initial(  ).
    assert( span->trace_id )->not_initial(  ).
    assert( span->span_id )->not_initial(  ).
    assert( span->name )->eq( span_name ).
    assert( span->parent_span_id )->initial(   ).
    assert( span->end_time )->initial( ).

    zcl_otel_trace=>api->use( processor ).
    assert( processor->counters )->initial( ).

    " Start child span
    data(child_span) = trace->start_span( name = 'Child span' context = span ).
    assert( child_span )->bound( ).
    assert( child_span->trace_id )->eq( span->trace_id ).
    assert( child_span->span_id )->ne( span->span_id ).
    assert( child_span->parent_span_id )->eq( span->span_id ).

    types counters like processor->counters.
    assert( processor->counters )->eq( value counters( span_start = 1 ) ).
    child_span->log( 'OK' ).

    child_span->end( ).
    assert( child_span->end_time )->not_initial( ).
    assert( processor->counters )->eq( value counters( span_start = 1 span_end = 1 span_event = 1 ) ).

    span->end( ).
    assert( span->end_time )->not_initial( ).
    assert( processor->counters )->eq( value counters( span_start = 1 span_end = 2 span_event = 1 ) ).

  endmethod.

endclass.
