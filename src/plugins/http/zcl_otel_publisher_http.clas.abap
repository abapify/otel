class ZCL_OTEL_PUBLISHER_HTTP definition
  public
  create public .

public section.

  interfaces ZIF_OTEL_MSG_BUS
      all methods final .

  types DESTINATION_TYPE type ref to ZIF_FETCH_DESTINATION .

  events MESSAGE_PUBLISHED
    exporting
      value(MESSAGE) type ref to ZIF_OTEL_MSG .

        " destination is optinal because this class may be redefined
        " alternative pattern is to redefine destination( ) method
  methods CONSTRUCTOR
    importing
      !DESTINATION type DESTINATION_TYPE optional
    preferred parameter DESTINATION .
  protected section.
    methods destination returning value(destination) type ref to zif_fetch_destination.
    methods client returning value(client) type ref to zif_fetch_client raising cx_static_check.
    methods request
      importing client type ref to zif_fetch_client
      message type ref to zif_otel_msg
      returning value(request) type ref to zif_fetch_request_setter raising cx_static_check.

  private section.

  methods throw importing message type string raising cx_static_check.


  data _destination type destination_type.


ENDCLASS.



CLASS ZCL_OTEL_PUBLISHER_HTTP IMPLEMENTATION.


  method CLIENT.
    data(destination) = destination( ).
    if destination is not bound.
        throw( '[Otel HTTP Exporter] Fetch destination is not provided').
    endif.

    client = destination->client( ).
  endmethod.


   METHOD CONSTRUCTOR.
    me->_destination = destination.
  ENDMETHOD.


  METHOD DESTINATION.
    destination = me->_destination.
  ENDMETHOD.


  method REQUEST.
    data(lo_request) = client->request( ).
    " method always POST as of now
    " do not know another cases when it should be different
    lo_request->method( method = 'POST' ).
    " content type must be declared prior to body
    lo_request->header( name = 'Content-Type' value = message->content_type( ) ).
    " body we can fill right now already too
    lo_request->body( message->get_binary( ) ).
    request = lo_request.
  endmethod.


  METHOD THROW.
    new zcl_throw( )->throw( message ).
  ENDMETHOD.


  method ZIF_OTEL_MSG_BUS~PUBLISH.
    data(client) = client( ).
    data(request) = request( client = client message = message ).
    data(response) = client->fetch( request ).

    raise event message_published
      exporting
        message = message
    .
  endmethod.
ENDCLASS.
