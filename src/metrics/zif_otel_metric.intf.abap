interface zif_otel_metric
  public .


  constants:
    begin of value_types,
      int type string value 'int',
      double type string value 'double',
    end of value_types .
  types:
    begin of ts_metric_options,
      unit        type string,
      description type string,
      value_type  type string,
    end of ts_metric_options .
  types attributes_type type zif_otel_attribute_map=>entries_tt .
  types context_type type ref to zif_otel_context .
  types value_type type f .

  data name type string read-only .
  data options type ts_metric_options read-only .

  types metric_type type string.
  data type type metric_type .

  methods set_unit
    importing
      !unit       type string
    returning
      value(self) type ref to zif_otel_metric .
  methods set_description
    importing
      !description type string
    returning
      value(self)  type ref to zif_otel_metric .
  methods set_double
    returning
      value(self) type ref to zif_otel_metric .
  methods add_value
    importing
      !value      type value_type
      !attributes type attributes_type optional
      context type context_type optional
      " it's not yet clear how we should use context in metrics
      "CONTEXT type CONTEXT_TYPE optional1
*    returning
*      value(RESULT) type ref to ZIF_OTEL_DATA_POINT
    .
endinterface.
