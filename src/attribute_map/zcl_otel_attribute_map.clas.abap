class zcl_otel_attribute_map definition  public
  create public .

  public section.
    interfaces zif_otel_attribute_map.
    aliases attribute for zif_otel_attribute_map~attribute.
    aliases get for zif_otel_attribute_map~attribute.
    methods constructor.

  protected section.
  private section.

    types attr_type type ref to zif_otel_attribute.
    types attr_ref_type type attr_type.

    data map type ref to zif_otel_map.

endclass.

class zcl_otel_attribute_map implementation.

  method constructor.

    super->constructor( ).
    me->map = new zcl_otel_map(  ).

  endmethod.

  method zif_otel_attribute_map~attribute.

    try.
        data(entry) = cast  attr_ref_type( me->map->get( key = name ) ).
      catch cx_sy_move_cast_error.
    endtry.

    if entry is not bound.
      entry = new #(
        new lcl_attribute( name )
      ).
      me->map->set(
        exporting
          key   = name
          value = entry->*
      ).
    endif.

    result = entry->*.

  endmethod.

  method zif_otel_attribute_map~values.

    result = value #(
        for value in me->map->values( )
        let ref = cast attr_ref_type( value )
        in ( ref->* ) ).

  endmethod.


  METHOD zif_otel_attribute_map~entries.

      result = value #(
        for value in me->map->values( )
        let ref = cast attr_ref_type( value )
            entry = ref->*
        in ( name = entry->name value = entry->get( ) ) ).

  ENDMETHOD.

  METHOD zif_otel_attribute_map~append.

    loop at entries into data(ls_entry).
        me->attribute( name = ls_entry-name )->set( ls_entry-value ).
    endloop.

  ENDMETHOD.

endclass.
