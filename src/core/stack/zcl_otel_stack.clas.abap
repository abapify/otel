class zcl_otel_stack definition
  public
  final
  create public .

  public section.
  interfaces zif_otel_stack.
  protected section.
  private section.
  data _stack type table of ref to data.
ENDCLASS.



CLASS ZCL_OTEL_STACK IMPLEMENTATION.


  method zif_otel_stack~last.
    check _stack is not initial.
    data = _stack[ 1 ].
  endmethod.


  method zif_otel_stack~pop.
    data = me->zif_otel_stack~last( ).
    check data is bound.
    delete _stack index 1.
  endmethod.


 method zif_otel_stack~push.

   " we always create a new reference otherwise it may be freed
   assign data->* to field-symbol(<data>).

   if <data> is assigned.
     data stack_data type ref to data.
     create data stack_data like <data>.
     assign stack_data->* to field-symbol(<stack_data>).
     <stack_data> = <data>.
   endif.

    insert stack_data into _stack index 1.
  endmethod.
ENDCLASS.
