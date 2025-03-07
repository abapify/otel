interface zif_otel_span_kind
  public .

  types span_kind_type type i.

  constants:
    begin of span_kind,
      internal type span_kind_type value 0,
      server   type span_kind_type value 1,
      client   type span_kind_type value 2,
      producer type span_kind_type value 3,
      consumer type span_kind_type value 4,
    end of span_kind.


endinterface.
