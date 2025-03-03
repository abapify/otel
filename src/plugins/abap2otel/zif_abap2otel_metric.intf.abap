"! ABAP2OTEL Metric Format Interface
"! Defines a lightweight, JSON-compatible structure for metrics.
interface zif_abap2otel_metric public.

   types:
    attributes_tt type zif_otel_attribute_map=>entries_tt,

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
    end of metric_ts.

endinterface.
