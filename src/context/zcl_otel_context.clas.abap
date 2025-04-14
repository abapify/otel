class zcl_otel_context definition
  public

  create public .

  public section.
    methods constructor importing context type ref to zif_otel_context optional.
    interfaces zif_otel_context.
  protected section.
  private section.

  data value_map type ref to zif_otel_map.

ENDCLASS.



CLASS ZCL_OTEL_CONTEXT IMPLEMENTATION.


  method constructor.

    super->constructor( ).
    me->value_map = new zcl_otel_map( ).

    if context is bound.
      me->zif_otel_context~parent_context  = context.
      me->zif_otel_context~root_context  = context->root_context.

      " inherit entries from context
      loop at context->get_entries( ) into data(ls_entry).
        me->value_map->set(
          key   = ls_entry-key
          value = ls_entry-value
        ).
      endloop.

    endif.


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
ENDCLASS.
