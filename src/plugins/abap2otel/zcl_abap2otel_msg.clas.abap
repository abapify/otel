class ZCL_ABAP2OTEL_MSG definition
  public
  inheriting from ZCL_OTEL_MSG_JSON
  final
  create public

  global friends ZCL_ABAP2OTEL_SPAN_PROCESSOR .

public section.

  types MESSAGE_TYPE type ZIF_ABAP2OTEL=>MESSAGE_TS .

  methods ADD_SPAN
    importing
      !SPAN type ref to ZIF_OTEL_SPAN .
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


  method add_span.

    types span_ts type line of message_type-spans.

    append value span_ts(
      name           = span->name
      span_id        = to_lower( conv string( span->span_id ) )
      trace_id       = to_lower( conv string( span->trace_id ) )
      parent_span_id = to_lower( conv string( span->parent_span_id ) )
      start_time     = span->start_time
      end_time       = span->end_time
      "attrs          = span->attributes
      events         = value #( for event in span->events
                        ( name      = event->name
*         attrs = event->attributes
                          timestamp = event->timestamp
                        )
                        )
*      status         = span->status
      links          = value #( for link in span->links
                        ( span_id   = link->context->span_id
                          trace_id  = link->context->trace_id
                       )
                       )
     ) to message->spans.
    me->_size = me->_size + 1.
  endmethod.


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
