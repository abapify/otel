INTERFACE zif_otel_data_point
  PUBLIC.

  data value type f read-only.
  data context TYPE ref to zif_otel_context read-only.
  data attributes TYPE ref to zif_otel_attributes read-only.

ENDINTERFACE.
