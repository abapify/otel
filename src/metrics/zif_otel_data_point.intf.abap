interface zif_otel_data_point
  public .

   DATA value TYPE zif_otel_metric=>value_type read-only.
   DATA attributes TYPE  zif_otel_metric=>attributes_type read-only.
   DATA context TYPE zif_otel_metric=>context_type read-only.

endinterface.
