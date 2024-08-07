class zcl_abap2otel_msg definition
  public
  inheriting from zcl_otel_msg_json
  final
  create public

  global friends zcl_abap2otel_span_processor .

  public section.

    types message_type type zif_abap2otel=>message_ts .

    methods add_span
      importing
        !span type ref to zif_otel_span .
    methods size
      returning
        value(result) type i .
    methods constructor .
  protected section.

    methods get_data
        redefinition .
    methods get_source
        redefinition .
  private section.
    data message type ref to  message_type.
    data _size type i.

endclass.

class zcl_abap2otel_msg implementation.

  method add_span.

    data(span_ref) = cast zcl_otel_span( span ).
    data(span_flat) = span_ref->get_serializable( ).

    append span_flat->span_data to message->spans.
    me->_size = me->_size + 1.
  endmethod.

  method constructor.
    super->constructor( ).
    me->message = new #( ).
  endmethod.

  method get_data.
    result = message.
  endmethod.

  method get_source.

    " otherwise we need to introduce a static format with data as root
    " currently it is not supported by our ABAP2Otel spec

    result = value #(
     ( name = 'SPANS'  value = ref #( me->message->spans ) )
     ( name = 'LOGS'   value = ref #( me->message->logs ) )
     ( name = 'METRICS' value = ref #( me->message->metrics ) )
    ).

  endmethod.

  method size.
    " very simple logic - we assume 1 record in one of those tables = 1 message
    result = me->_size.
  endmethod.
endclass.
