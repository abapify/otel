class zcl_otel_http_exporter definition
  public
  abstract .

  public section.
    interfaces zif_otel_msg_bus all methods final.

  protected section.
    methods destination abstract returning value(result) type ref to zif_fetch_destination.
    methods client returning value(client) type ref to zif_fetch_client raising cx_static_check.
    methods request
      importing client type ref to zif_fetch_client
      message type ref to zif_otel_msg
      returning value(request) type ref to zif_fetch_request_setter raising cx_static_check.

    methods content_type abstract returning value(content_type) type string.
  private section.

endclass.

class zcl_otel_http_exporter implementation.
  method client.
    data(destination) = destination( ).
    client = destination->client( ).
  endmethod.

  method request.
    data(lo_request) = client->request( ).
    lo_request->method( method = 'POST' ).
    lo_request->body( message->get_binary( ) ).
    lo_request->header( name = 'Content-Type' value = content_type( ) ).
    request = lo_request.
  endmethod.


  method zif_otel_msg_bus~publish.
    data(client) = client( ).
    data(request) = request( client = client message = message ).
    data(response) = client->fetch( request ).
  endmethod.
endclass.
