interface ZIF_OTEL_ATTRIBUTE
  public .

  data name type string read-only.

  methods get returning value(result) type string.
  methods set importing value type csequence.
  methods set_getter importing getter type ref to zif_otel_attribute_getter.

endinterface.
