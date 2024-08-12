class zcl_otel_map definition
  public

  create public .

  public section.
    interfaces zif_otel_map.
  protected section.
  private section.

    aliases entries_tt for zif_otel_map~entries_tt.
    aliases key_type for zif_otel_map~key_type.
    data _entries type entries_tt.

    types entry_ts type line of entries_tt.
    methods _entry importing key type csequence returning value(result) type ref to entry_ts
     raising cx_sy_itab_line_not_found.
endclass.



class zcl_otel_map implementation.
  method _entry.
    result = ref #( me->_entries[  key key components key = key ] ).
  endmethod.
  method zif_otel_map~get.
    try.
        data(entry) = _entry( key ).

        " support ZIF_OTEL_MAP_GETTER
        try.

            assign entry->value->* to field-symbol(<value>).
            data(getter) = cast zif_otel_map_getter( <value> ).
            result = getter->get(  ).
            return.

        catch cx_sy_move_cast_error.
        endtry.

        result = entry->value.
      catch cx_sy_itab_line_not_found.
    endtry.
  endmethod.
  method zif_otel_map~set.

    " we need to create a new data reference, because the value may get lost
    data value_ref type ref to data.
    create data value_ref like value.
    assign value_ref->* to field-symbol(<value>).
    check <value> is assigned.
    <value> = value.


    try.
        data(entry) = _entry( key ).
        entry->value = value_ref.
      catch cx_sy_itab_line_not_found.
        append value #( key = key value = value_ref ) to me->_entries.
    endtry.

  endmethod.

  method zif_otel_map~size.

    result = lines( me->_entries ).

  endmethod.

  method zif_otel_map~has.
    result = xsdbool( line_exists( me->_entries[ key key components key = key ] ) ).
  endmethod.

  method zif_otel_map~keys.
    result = value #(  for entry in me->_entries ( entry-key  ) ).
  endmethod.

  method zif_otel_map~values.
    result = value #(  for entry in me->_entries ( entry-value ) ).
  endmethod.

  method zif_otel_map~entries.
    result = me->_entries.
  endmethod.

  method zif_otel_map~clear.
    clear me->_entries.
  endmethod.

  method zif_otel_map~delete.
    delete me->_entries using key key where key = conv string( key ).
  endmethod.

endclass.
