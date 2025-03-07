class zcl_otel_api_badi_base definition
  public
  create protected .

  public section.
    interfaces zif_otel_api_badi.
    methods constructor.

  protected section.

    methods app returning value(result) type ref to zif_otel_api_manager.

  private section.

    data manager type ref to zcl_otel_api_manager.

endclass.

class zcl_otel_api_badi_base implementation.

  method constructor.
    me->manager = new #( ).
  endmethod.

  method zif_otel_api_badi~api.

    result = me->manager.

  endmethod.

  method app.

    result = me->manager.

  endmethod.

endclass.
