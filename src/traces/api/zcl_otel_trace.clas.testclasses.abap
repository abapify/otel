*"* use this source file for your ABAP unit test classes
CLASS ltcl_main DEFINITION INHERITING FROM zcl_assert
    FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS:
      simple_run FOR TESTING RAISING cx_static_check.
ENDCLASS.


CLASS ltcl_main IMPLEMENTATION.

  METHOD simple_run.

    DATA(trace) = zcl_otel_trace=>api->get_tracer( ).

    assert( trace )->bound( ).


    DATA(span_name) = 'Root span'.
    DATA(span) = trace->start_span( span_name ).

    assert( span )->bound( ).
    assert( span->start_time )->NOT_initial(  ).
    assert( span->span_id )->NOT_initial(  ).
    assert( span->name )->eq( span_name ).
    assert( span->parent_span_id )->initial(   ).
    assert( span->end_time )->initial( ).

  ENDMETHOD.

ENDCLASS.
