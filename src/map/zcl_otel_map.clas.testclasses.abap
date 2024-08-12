*"* use this source file for your ABAP unit test classes
class ltcl_map definition final for testing inheriting from zcl_assertable_unit
  duration short
  risk level harmless.

  private section.
    methods: setup.
    methods:
      main for testing raising cx_static_check.
    data map type ref to zif_otel_map.
endclass.

class lcl_test_getter definition.
  public section.
    interfaces zif_otel_map_getter.
endclass.

class lcl_test_getter implementation.
  method zif_otel_map_getter~get.
    value = ref #( 'Test result' ).
  endmethod.
endclass.


class ltcl_map implementation.

  method setup.
    map = new zcl_otel_map( ).
  endmethod.

  method main.

    data(key_1) = '1'.
    data(key_2) = '2'.
    data(value_1) = 'Value 1'.
    data(value_2) = 'Value 2'.

    assert( map->size(  ) )->initial( ).
    assert( map->keys(  ) )->initial( ).
    assert( map->values(  ) )->initial( ).
    assert( map->entries(  ) )->initial( ).
    assert( map->get( key_1 ) )->initial( ).

    map->set( key = '1' value = value_1 ).

    assert( map->size(  ) )->eq( 1 ).
    assert( lines( map->keys(  ) ) )->eq( 1 ).
    assert( lines( map->values(  ) ) )->eq( 1 ).
    assert( lines( map->entries(  ) ) )->eq( 1 ).
    assert( map->get( key_1 ) )->ref( )->eq( value_1 ).

    map->set( key = '2' value = value_2 ).
    assert( map->size(  ) )->eq( 2 ).
    assert( map->get( key_2 ) )->ref( )->eq( value_2 ).
    map->set( key = '2' value = value_1 ).
    assert( map->get( key_2 ) )->ref( )->eq( value_1 ).

    assert( map->has( key_2 ) )->true( ).
    map->delete( key_2 ).
    assert( map->size(  ) )->eq( 1 ).
    assert( map->has( key_2 ) )->false( ).

    map->set( key = key_2 value = new lcl_test_getter( ) ).
    assert( map->get( key_2 ) )->ref( )->eq( 'Test result' ).

    map->clear( ).
    assert( map->size(  ) )->eq( 0 ).

  endmethod.

endclass.
