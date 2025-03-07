class zcl_abap2otel_processor definition inheriting from zcl_otel_processor
  public
  final
  create public .

  public section.

    types buffer_type type ref to zcl_abap2otel_msg.

    methods constructor importing buffer type buffer_type.

  protected section.
  private section.

endclass.

class zcl_abap2otel_processor implementation.


  method constructor.

    super->constructor( collector = new zcl_abap2otel_collector( buffer = buffer )  ).

  endmethod.


endclass.
