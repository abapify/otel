interface zif_otel_attribute_map
  public .
  types:
    begin of entry_ts,
      name type string,
      value type string,
    end of entry_ts,
    entries_tt type table of entry_ts with empty key,
    keys_tt type ZIF_OTEL_MAP=>keys_tt.
  types values_tt type table of ref to zif_otel_attribute with empty key.
  methods attribute importing name type csequence returning value(result) type ref to zif_otel_attribute.
  methods values returning value(result) type values_tt.
  methods entries importing keys type keys_tt optional returning value(result) type entries_tt.
  methods append importing entries type entries_tt.

endinterface.
