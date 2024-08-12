*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
class lcl_attribute definition.
public section.
methods constructor
importing name type csequence.
interfaces zif_otel_attribute.
private section.
data value type string.
data getter type ref to zif_otel_attribute_getter.
endclass.

class lcl_attribute implementation.
  method constructor.
    super->constructor( ).
    me->zif_otel_attribute~name = name.
  endmethod.

  METHOD zif_otel_attribute~get.

    if me->getter is bound.
      result = me->getter->get( ).
    else.
      result = me->value.

    endif.
  ENDMETHOD.

  METHOD zif_otel_attribute~set.
    me->value = value.
  ENDMETHOD.

  METHOD zif_otel_attribute~set_getter.
    me->getter = getter.
  ENDMETHOD.

endclass.
