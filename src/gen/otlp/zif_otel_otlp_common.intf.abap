INTERFACE zif_otel_otlp_common PUBLIC.

  TYPES:
    "! AnyValue primitive types
    string_value TYPE string,
    bool_value   TYPE abap_bool,
    int_value    TYPE int8,
    double_value TYPE f,
    bytes_value  TYPE xstring.

  TYPES:
    BEGIN OF any_value,
      string_value TYPE string_value,
      bool_value   TYPE bool_value,
      int_value    TYPE int_value,
      double_value TYPE double_value,
      array_value  TYPE REF TO data, "array_value
      kvlist_value TYPE REF TO data, "key_value_list
      bytes_value  TYPE bytes_value,
    END OF any_value.

  TYPES:
    any_values TYPE STANDARD TABLE OF any_value WITH EMPTY KEY.

  TYPES:
    BEGIN OF array_value,
      values TYPE any_values,
    END OF array_value.

  TYPES:
    BEGIN OF key_value,
      key   TYPE string,
      value TYPE any_value,
    END OF key_value.

  TYPES:
    key_values TYPE STANDARD TABLE OF key_value WITH EMPTY KEY.

  TYPES:
    BEGIN OF key_value_list,
      values TYPE key_values,
    END OF key_value_list.

  TYPES:
    BEGIN OF instrumentation_scope,
      name                    TYPE string,
      version                 TYPE string,
      attributes             TYPE key_values,
      dropped_attributes_count TYPE i,
    END OF instrumentation_scope.

ENDINTERFACE.
