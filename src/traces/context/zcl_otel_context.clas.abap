class zcl_otel_context definition
  public

  create public .

  public section.
    methods constructor importing context type ref to zif_otel_context optional.
    interfaces zif_otel_context.
    interfaces zif_otel_has_attributes.

    class-methods from importing context_data type any returning value(result) type ref to zif_otel_context.

  protected section.
  private section.

  data attributes type ref to zcl_otel_attribute_map.

endclass.



class zcl_otel_context implementation.

  method constructor.

    super->constructor( ).
    if context is bound.
      me->zif_otel_context~parent_context  = context.
      me->zif_otel_context~root_context  = context->root_context.
    endif.
    me->attributes = new #(  ).

  endmethod.


  METHOD zif_otel_has_attributes~attributes.

    result = me->attributes.

  ENDMETHOD.

  METHOD from.




  ENDMETHOD.

  METHOD zif_otel_context~get_value.

  ENDMETHOD.

  METHOD zif_otel_context~set_value.

  ENDMETHOD.

  METHOD zif_otel_context~delete_value.

  ENDMETHOD.

  METHOD zif_otel_context~get_entries.

  ENDMETHOD.

endclass.
