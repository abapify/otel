class zcl_otel_stack definition
  public
  final
  create public .

  public section.
  interfaces zif_otel_stack.
  protected section.
  private section.
  data _stack type table of ref to data.
endclass.



class zcl_otel_stack implementation.
 method zif_otel_stack~push.
    insert data into _stack index 1.
  endmethod.

  method zif_otel_stack~pop.
    data = me->zif_otel_stack~last( ).
    check data is bound.
    delete _stack index 1.
  endmethod.

  method zif_otel_stack~last.
    check _stack is not initial.
    data = _stack[ 1 ].
  endmethod.

endclass.
