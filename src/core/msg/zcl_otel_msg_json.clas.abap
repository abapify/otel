class ZCL_OTEL_MSG_JSON definition
  public
  abstract
  create public .

public section.

  interfaces ZIF_OTEL_MSG .
protected section.

  methods GET_SOURCE
    returning
      value(RESULT) type ABAP_TRANS_SRCBIND_TAB .
  methods GET_DATA
  abstract
    returning
      value(RESULT) type ref to DATA .
private section.
ENDCLASS.



CLASS ZCL_OTEL_MSG_JSON IMPLEMENTATION.


  method GET_SOURCE.
    result = value #(
      ( name = 'DATA' value = get_data( ) )
    ).
  endmethod.


  method zif_otel_msg~content_type.
    content_type = 'application/json'.
  endmethod.


  method zif_otel_msg~get_binary.

    data(mr_message) = get_data( ).

    check mr_message is bound.
    assign mr_message->* to field-symbol(<ls_message>).
    check <ls_message> is assigned.

    data(json) = cl_sxml_string_writer=>create( if_sxml=>co_xt_json ).

    data(source) = get_source( ).

    call transformation id
    options
      initial_components = 'suppress'
      source (source)
      result xml json.

    result = json->get_output( ).

  endmethod.
ENDCLASS.
