class zcl_otel_http_exporter definition
  public
   .

  public section.
    interfaces zif_otel_msg_bus all methods final.

    events message_published exporting value(message) type ref to zif_otel_msg.

    types destination_type type ref to zif_fetch_destination.

    methods
        constructor importing
        " destination is optinal because this class may be redefined
        " alternative pattern is to redefine destination( ) method
        destination type destination_type optional
        preferred parameter destination.

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



CLASS ZCL_OTEL_HTTP_EXPORTER IMPLEMENTATION.


  method client.
    data(destination) = destination( ).
    if destination is not bound.
        throw( '[Otel HTTP Exporter] Fetch destination is not provided').
    endif.

    client = destination->client( ).
  endmethod.


   METHOD constructor.
    me->_destination = destination.
  ENDMETHOD.


  METHOD destination.
    destination = me->_destination.
  ENDMETHOD.


  method request.
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


  METHOD throw.
    new zcl_throw( )->throw( message ).
  ENDMETHOD.


  method zif_otel_msg_bus~publish.
    data(client) = client( ).
    data(request) = request( client = client message = message ).
    data(response) = client->fetch( request ).

    raise event message_published
      exporting
        message = message
    .
  endmethod.
ENDCLASS.
