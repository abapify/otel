class zcl_abap2otel_msg definition inheriting from zcl_otel_msg_json
  public
  final
  create private global friends zcl_abap2otel_span_processor .

  public section.

    types message_type type zif_abap2otel=>message_ts.

    methods add_span importing span type line of message_type-spans.
    methods size returning value(result) type i.
    methods constructor.

  protected section.
    METHODS: get_data REDEFINITION.
  private section.
    data message type ref to  message_type.
    data _size type i.

endclass.



class zcl_abap2otel_msg implementation.
  method get_data.
    result = message.
  endmethod.
  METHOD add_span.
    append span to message->spans.
    me->_size = me->_size + 1.
  ENDMETHOD.
  METHOD size.
    " very simple logic - we assume 1 record in one of those tables = 1 message
    result = me->_size.
  ENDMETHOD.

  METHOD constructor.
    super->constructor( ).
    me->message = new #( ).
  ENDMETHOD.

endclass.
