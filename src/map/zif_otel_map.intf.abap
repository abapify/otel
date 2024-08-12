interface ZIF_OTEL_MAP
  public .

  types: key_type type string.
  types: keys_tt type hashed table of key_type with unique default key.
  types: values_tt type table of ref to data with empty key.
  types: begin of entry_ts,
            key type key_type,
            value type ref to data,
         end of entry_ts.
  types: entries_tt type table of entry_ts with empty key
            with unique hashed key key components key
            with non-unique sorted key value components value.

  methods get importing key type csequence returning value(result) type ref to data.
  methods set importing key type csequence value type any.
  methods size returning value(result) type i.
  methods has importing key type csequence returning value(result) type abap_bool.
  methods keys returning value(result) type keys_tt.
  methods values returning value(result) type values_tt.
  methods entries returning value(result) type entries_tt.
  methods clear.
  methods delete importing key type csequence.

endinterface.
