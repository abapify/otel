interface zif_abap2otel
  public .
  types:
    span_ts type zif_otel_span_serializable=>span_ts,
    begin of logs_ts,
      to_do type abap_bool,
    end of logs_ts,
    begin of attributes_ts,
      key   type string,
      value type string,
    end of attributes_ts ,
    attributes_tt type table of attributes_ts with empty key
      with unique hashed key key components key,
    begin of metric_data_point_ts,
      attrs type attributes_tt,
      " it must be string to support 0 values
      " otherwise in combination with intital_components = suppress
      " during transformation value will be removed
      value type string,
      ts type xsddatetime_long_z,
    end of metric_data_point_ts,
    begin of metric_ts,
      name        type string,
      type        type string,
      description type string,
      unit        type string,
      data_points type table of metric_data_point_ts with empty key,
      value_type  type string,
    end of metric_ts,
    begin of message_ts,
      spans   type table of span_ts    with empty key,
      logs    type table of logs_ts    with empty key,
      metrics type table of metric_ts with empty key,
    end of message_ts.

endinterface.
