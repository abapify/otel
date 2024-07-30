interface zif_otel_span_event
  public .
  data name type string read-only.
  data span type ref to zif_otel_span read-only.
  data timestamp type timestampl read-only.
endinterface.
