class zcl_abap2otel_msg definition
  public
  inheriting from zcl_otel_msg_json
  create public

  global friends zcl_abap2otel_span_processor .

  public section.

    interfaces zif_otel_span_collector.

    types message_type type zif_abap2otel=>message_ts .

    aliases add_span for zif_otel_span_collector~add_span.
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

ENDCLASS.



CLASS ZCL_ABAP2OTEL_MSG IMPLEMENTATION.


  method add_span.
    check span is bound.
    append span->span_data to message->spans.
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
ENDCLASS.
