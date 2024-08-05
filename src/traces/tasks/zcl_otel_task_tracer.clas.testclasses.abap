*"* use this source file for your ABAP unit test classes
class ltcl_tracer definition final for testing inheriting from zcl_assertable_unit
  duration short
  risk level harmless.

  public section.
    interfaces zif_otel_traceable_task.
  private section.
    methods:
      test_ok             for testing raising cx_static_check,
      test_failed_with_cx for testing raising cx_static_check.
    data executed type abap_bool.
    data must_fail type abap_bool.
endclass.

class ltcx_error definition for testing inheriting from cx_static_check.
endclass.

class ltcl_tracer implementation.
  method test_ok.
    new zcl_otel_task_tracer( 'Test span' )->execute_task( me ).
*    catch cx_static_check.
    assert( me->executed )->true( ).
  endmethod.
  method test_failed_with_cx.
    me->must_fail = abap_true.
    try.
        new zcl_otel_task_tracer( 'Test span' )->execute_task( me ).
      catch ltcx_error into data(lo_cx).
    endtry.
    assert( lo_cx )->bound( ).
    assert( me->executed )->false( ).
  endmethod.

  method zif_otel_traceable_task~execute.
    assert span is bound.
    span->log( 'Started' ).

    if me->must_fail eq abap_true.
      raise exception type ltcx_error.
    endif.

    me->executed = abap_true.
    span->log( 'Done' ).

  endmethod.

endclass.
