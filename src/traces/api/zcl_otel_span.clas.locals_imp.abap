*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
class lcl_randomizer definition.
  public section.
    class-methods generate_hex importing length type i returning value(result) type xstring.
  private section.

endclass.

class lcl_randomizer implementation.
  " earlier I tried to generate random hex string using cl_abap_random
  " the result was same but 5 times slower than this algorithm
  " we ran tests for 100K records - no unique lines
  method generate_hex.

    try.
        data(lv_uuid) = cl_system_uuid=>create_uuid_x16_static( ).

        cl_abap_hmac=>calculate_hmac_for_raw(
          exporting
*        if_algorithm     = 'SHA1'
            if_key           = value xstring( )
            if_data          = conv #( lv_uuid )
*        if_length        = 0
          importing
*        ef_hmacstring    = data(lv_hmac)
            ef_hmacxstring   =  data(lv_hmac)
*        ef_hmacb64string =
        ).

        result = lv_hmac(length).

      catch cx_uuid_error.
        "handle exception
      catch cx_abap_message_digest.
        "handle exception
    endtry.

  endmethod.

endclass.

class lcl_span_event definition friends zcl_otel_span.
  public section.
    interfaces zif_otel_span_event.
  private section.
    aliases name for zif_otel_span_event~name.
    aliases span for zif_otel_span_event~span.
endclass.

class lcl_span_link definition friends zcl_otel_span.
  public section.
    interfaces zif_otel_span_link.
  private section.
    aliases context for zif_otel_span_link~context.
endclass.

class lcl_serializable_span definition create private friends zcl_otel_span.
public section.
interfaces zif_otel_span_serializable.
endclass.
