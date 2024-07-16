*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
CLASS lcl_randomizer DEFINITION.
PUBLIC SECTION.
class-METHODS generate_hex IMPORTING length TYPE i RETURNING VALUE(result) TYPE xstring.
PRIVATE SECTION.

ENDCLASS.

CLASS lcl_randomizer IMPLEMENTATION.
" earlier I tried to generate random hex string using cl_abap_random
" the result was same but 5 times slower than this algorithm
" we ran tests for 100K records - no unique lines
METHOD generate_hex.

try.
    data(lv_uuid) = cl_system_uuid=>create_uuid_x16_static( ).

    cl_abap_hmac=>calculate_hmac_for_raw(
      EXPORTING
*        if_algorithm     = 'SHA1'
        if_key           = value xstring( )
        if_data          = conv #( lv_uuid )
*        if_length        = 0
      IMPORTING
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




*CATCH cx_abap_message_digest.

ENDMETHOD.

ENDCLASS.
