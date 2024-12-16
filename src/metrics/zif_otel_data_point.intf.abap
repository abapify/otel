interface zif_otel_data_point
  public .

   types attributes_type type zif_otel_attribute_map=>entries_tt.
   types context_type type ref to zif_otel_context.
   types value_type type f.

   DATA value TYPE value_type read-only.
   DATA attributes TYPE attributes_type read-only.
   DATA context TYPE context_type read-only.

endinterface.
