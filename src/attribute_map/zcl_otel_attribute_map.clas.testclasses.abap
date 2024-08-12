*"* use this source file for your ABAP unit test classes
class ltcl_main definition final for testing
inheriting from zcl_assertable_unit
  duration short
  risk level harmless.

  private section.
    methods:
      main for testing raising cx_static_check.
endclass.

class lcl_getter_inc definition.
  public section.
    interfaces zif_otel_attribute_getter.
  private section.
    data counter type i.
endclass.

class lcl_getter_inc implementation.
  method zif_otel_attribute_getter~get.
    me->counter = me->counter + 1.
    result = me->counter.
  endmethod.

endclass.

class ltcl_main implementation.

  method main.

    data(test_attr) = 'test'.
    data(attributes) = new zcl_otel_attribute_map( ).

    "map should create attributes even without adding them
    data(test) = attributes->get( test_attr ).

    assert( test )->bound( ).
    assert( test->get( ) )->initial(  ).
    assert( test->name )->eq( test_attr ).
    assert( attributes->get( test_attr ) )->eq( test ).

    data(test_value) = 'Test value'.
    test->set( test_value ).

    assert(  test->get(  ) )->eq( test_value ).

    data(counter) = attributes->get( 'Counter' ).
    counter->set_getter( new lcl_getter_inc(  ) ).
    assert(  counter->get( ) )->eq( 1 ).
    assert(  counter->get( ) )->eq( 2 ).


  endmethod.

endclass.
