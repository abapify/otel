interface zif_otel_scope
  public .

  interfaces zif_otel_has_attributes.
  aliases attributes for zif_otel_has_attributes~attributes.

  data name type string read-only.
  data version type string read-only.

endinterface.
