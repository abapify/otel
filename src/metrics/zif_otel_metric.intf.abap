interface ZIF_OTEL_METRIC
  public .


  types:
    BEGIN OF ENUM te_value_type,
      int,
      double,
    END OF ENUM te_value_type .
  types:
    BEGIN OF ts_metric_options,
      unit        TYPE string,
      description TYPE string,
      value_type  type te_value_type,
    END OF ts_metric_options .
  types ATTRIBUTES_TYPE type ZIF_OTEL_ATTRIBUTE_MAP=>ENTRIES_TT .
  types CONTEXT_TYPE type ref to ZIF_OTEL_CONTEXT .
  types VALUE_TYPE type F .

  data NAME type STRING read-only .
  data OPTIONS type TS_METRIC_OPTIONS read-only .

  types metric_type type string.
  data TYPE type metric_type .

  methods SET_UNIT
    importing
      !UNIT type STRING
    returning
      value(SELF) type ref to ZIF_OTEL_METRIC .
  methods SET_DESCRIPTION
    importing
      !DESCRIPTION type STRING
    returning
      value(SELF) type ref to ZIF_OTEL_METRIC .
  methods SET_DOUBLE
    returning
      value(SELF) type ref to ZIF_OTEL_METRIC .
  methods ADD_VALUE
    importing
      !VALUE type VALUE_TYPE
      !ATTRIBUTES type ATTRIBUTES_TYPE optional
      !CONTEXT type CONTEXT_TYPE optional
    returning
      value(RESULT) type ref to ZIF_OTEL_DATA_POINT .
endinterface.
