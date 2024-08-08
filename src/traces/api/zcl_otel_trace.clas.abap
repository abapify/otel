class ZCL_OTEL_TRACE definition
  public
  abstract
  final
  create public .

public section.

    " default implementation
  class-data API type ref to ZIF_OTEL_TRACE_API read-only .

  class-methods CLASS_CONSTRUCTOR .
    " get api instance ( advanced scenario )
  class-methods GET
    returning
      value(RESULT) type ref to ZIF_OTEL_TRACE_API .
  protected section.
  private section.

ENDCLASS.



CLASS ZCL_OTEL_TRACE IMPLEMENTATION.


  method class_constructor.
    " default implementation
    api = get( ).
  endmethod.


  method get.
     result = new zcl_otel_trace_controller( ).
  endmethod.
ENDCLASS.
