class zcl_otel_context definition
  public

  create public .

  public section.
    methods constructor importing context type ref to zif_otel_context optional.
    interfaces zif_otel_context.
  protected section.
  private section.

  data value_map type ref to zif_otel_map.

endclass.

class zcl_otel_context implementation.

  method constructor.

    super->constructor( ).
    if context is bound.
      me->zif_otel_context~parent_context  = context.
      me->zif_otel_context~root_context  = context->root_context.
    endif.
    me->value_map = new zcl_otel_map( ).

  endmethod.

  METHOD zif_otel_context~get_value.
    value = me->value_map->get( key ).
  ENDMETHOD.

  METHOD zif_otel_context~set_value.

    me->value_map->set(
      key   = key
      value = value
    ).

  ENDMETHOD.

  METHOD zif_otel_context~delete_value.

    me->value_map->delete( key = key ).

  ENDMETHOD.

  METHOD zif_otel_context~get_entries.

    entries = me->value_map->entries(
*      receiving
*        result =
    ).

  ENDMETHOD.

endclass.
