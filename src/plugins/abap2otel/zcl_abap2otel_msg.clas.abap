class ZCL_ABAP2OTEL_MSG definition
  public
  inheriting from ZCL_OTEL_MSG_JSON
  final
  create private

  global friends ZCL_ABAP2OTEL_SPAN_PROCESSOR .

public section.

  types MESSAGE_TYPE type ZIF_ABAP2OTEL=>MESSAGE_TS .

  methods ADD_SPAN
    importing
      !SPAN type LINE OF MESSAGE_TYPE-SPANS .
  methods SIZE
    returning
      value(RESULT) type I .
  methods CONSTRUCTOR .
protected section.

  methods GET_DATA
    redefinition .
  methods GET_SOURCE
    redefinition .
  private section.
    data message type ref to  message_type.
    data _size type i.

ENDCLASS.



CLASS ZCL_ABAP2OTEL_MSG IMPLEMENTATION.


  METHOD add_span.
    append span to message->spans.
    me->_size = me->_size + 1.
  ENDMETHOD.


  METHOD constructor.
    super->constructor( ).
    me->message = new #( ).
  ENDMETHOD.


  method get_data.
    result = message.
  endmethod.


  method GET_SOURCE.

    " otherwise we need to introduce a static format with data as root
    " currently it is not supported by our ABAP2Otel spec

    result = value #(
     ( name = 'SPANS'  value = ref #( me->message->spans ) )
     ( name = 'LOGS'   value = ref #( me->message->logs ) )
     ( name = 'METRICS' value = ref #( me->message->metrics ) )
    ).

  endmethod.


  METHOD size.
    " very simple logic - we assume 1 record in one of those tables = 1 message
    result = me->_size.
  ENDMETHOD.
ENDCLASS.
