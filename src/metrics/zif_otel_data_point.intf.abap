interface zif_otel_data_point
  public .

   interfaces zif_otel_has_attributes.

   types value_type type f.

   DATA value TYPE value_type read-only.

   aliases attributes for zif_otel_has_attributes~attributes.
   "DATA context TYPE context_type read-only.

*
*   types keys_tt type table of string with empty key.
*
*   methods inherit_from_context
*     importing
*        attributes type keys_tt.

endinterface.
