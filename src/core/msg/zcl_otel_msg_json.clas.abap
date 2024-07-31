class zcl_otel_msg_json definition
  public
  abstract
  create public .

  public section.
    interfaces zif_otel_msg.
  protected section.
    methods get_data abstract returning value(result) type ref to data.
  private section.
endclass.



class zcl_otel_msg_json implementation.
  method zif_otel_msg~get_binary.

    data(mr_message) = get_data( ).

    check mr_message is bound.
    assign mr_message->* to field-symbol(<ls_message>).
    check <ls_message> is assigned.

    data(json) = cl_sxml_string_writer=>create( if_sxml=>co_xt_json ).

    call transformation id
    options
      initial_components = 'suppress'
      source data = <ls_message>
      result xml json.

    result = json->get_output( ).

  endmethod.
  method zif_otel_msg~content_type.
    content_type = 'application/json'.
  endmethod.

endclass.
