interface ZIF_OTEL_METRIC_SERIALIZABLE
  public .


  interfaces IF_SERIALIZABLE_OBJECT .

  types:
    begin of attributes_ts,
      key   type string,
      value type string,
    end of attributes_ts .
  types:
    attributes_tt type table of attributes_ts with empty key
      with unique hashed key key components key .
  types ATTR_TT type ATTRIBUTES_TT .
  types:
    begin of event_ts,
      name      type string,
      timestamp type xsddatetime_long_z,
      severity  type i,
      attrs     type attr_tt,
    end of event_ts .
  types:
    begin of context_ts,
      trace_id type string,
      span_id  type string,
    end of context_ts .
  types:
    begin of link_ts.
      include type context_ts as _context.
    types:
      attrs type attr_tt,
    end of link_ts .
  types:
    begin of attribute_ts,
        name  type string,
        value type string,
      end of attribute_ts .
  types:
    begin of data_point_ts,
        value      type f,
        timestamp  type timestampl,
        attributes type table of attribute_ts with empty key,
      end of data_point_ts .
  types:
    begin of metric_ts,
        name        type string,
        unit        type string,
        description type string,
        value_type  type string,
        data_points type table of data_point_ts with empty key,
      end of metric_ts .
  types:
    begin of message_ts,
        meter_name  type string,
        metric_type type string,
        metric      type metric_ts,
      end of message_ts .

  data METRIC_DATA type MESSAGE_TS .
endinterface.
