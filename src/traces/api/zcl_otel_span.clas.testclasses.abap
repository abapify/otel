*"* use this source file for your ABAP unit test classes
class ltcl_main definition final for testing
  duration short
  risk level harmless.

  private section.
    methods:
      random_uuid for testing raising cx_static_check.
endclass.

class ltcl_main implementation.


  METHOD random_uuid.

  data(lv_random_string_1) = lcl_randomizer=>generate_hex( length = 16 ).
  data(lv_random_string_2) = lcl_randomizer=>generate_hex( length = 16 ).

  cl_abap_unit_assert=>assert_equals(
    EXPORTING
      act                  = xstrlen( lv_random_string_1 )
      exp                  = 16
  ).

  cl_abap_unit_assert=>assert_differs(
    EXPORTING
      act              = lv_random_string_1
      exp              = lv_random_string_2
*      tol              =
*      msg              =
*      level            = if_abap_unit_constant=>severity-medium
*      quit             = if_abap_unit_constant=>quit-test
*    RECEIVING
*      assertion_failed =
  ).

  ENDMETHOD.

endclass.
