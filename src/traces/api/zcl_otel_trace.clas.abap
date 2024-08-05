class zcl_otel_trace definition
  public
  final
  abstract.

  public section.

    " default implementation
    class-data api type ref to zif_otel_trace_api read-only.
    class-methods: class_constructor.

    " get api instance ( advanced scenario )
    class-methods get returning value(result) type ref to zif_otel_trace_api.

  protected section.
  private section.

endclass.

class zcl_otel_trace implementation.

  method class_constructor.
    " default implementation
    api = get( ).
  endmethod.

  method get.
     result = new zcl_otel_trace_controller( ).
  endmethod.

endclass.
