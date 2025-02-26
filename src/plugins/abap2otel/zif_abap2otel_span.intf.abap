interface zif_abap2otel_span
  public .

    types:
    begin of attributes_ts,
      key   type string,
      value type string,
    end of attributes_ts .
  types:
    attributes_tt type table of attributes_ts with empty key
      with unique hashed key key components key.

  types:
    attr_tt type attributes_tt,
    begin of event_ts,
      name      type string,
      timestamp type xsddatetime_long_z,
      severity  type i,
      attrs     type attr_tt,
    end of event_ts,
    begin of context_ts,
      trace_id type string,
      span_id  type string,
    end of context_ts,
    begin of link_ts.
      include type context_ts as _context.
    types:
      attrs type attr_tt,
    end of link_ts,
    begin of span_ts,
      name           type string,
      span_id        type string,
      trace_id       type string,
      parent_span_id type string,
      start_time     type xsddatetime_long_z,
      end_time       type xsddatetime_long_z,
      attrs          type attr_tt,
      events         type table of event_ts with empty key,
      status         type string,
      links          type table of link_ts with empty key,
    end of span_ts.

endinterface.
