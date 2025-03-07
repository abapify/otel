interface zif_otel_span_options
  public .

    types:
        begin of span_options,
            attributes type zif_otel_attribute_map=>entries_tt,
            kind type zif_otel_span_kind=>span_kind_type,
            links type table of ref to zif_otel_span_link with empty key,
            root type abap_bool,
            start_time type timestampl,
        end of span_options.

endinterface.
