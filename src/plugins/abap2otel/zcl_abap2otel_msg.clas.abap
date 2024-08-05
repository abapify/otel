class zcl_abap2otel_msg definition inheriting from zcl_otel_msg_json
  public
  final
  create private global friends zcl_abap2otel_span_processor .

  public section.
  protected section.
    METHODS: get_data REDEFINITION.
  private section.
    data message type ref to  zif_abap2otel=>message_ts.

endclass.



class zcl_abap2otel_msg implementation.
  method get_data.
    result = message.
  endmethod.
endclass.
