class zcl_otel_metric definition
  public

  create public abstract
  global friends zcl_otel_meter.

  public section.
    interfaces zif_otel_metric.
    methods constructor importing
                          type    type zif_otel_metric~metric_type
                          name    type string
                          options type zif_otel_metric~ts_metric_options optional.
  protected section.


  private section.

    aliases options for zif_otel_metric~options.
    aliases name for zif_otel_metric~name.
    aliases type for zif_otel_metric~type.
    events value_added exporting
                         value(data_point) type ref to zif_otel_data_point.

ENDCLASS.



CLASS ZCL_OTEL_METRIC IMPLEMENTATION.


  method zif_otel_metric~add_value.


    data(data_point) = new zcl_otel_data_point(
      value = value
      "context = context
      attributes = attributes ).

    raise event value_added exporting data_point = data_point.

    "result = data_point.

  endmethod.


  method zif_otel_metric~set_description.

    me->options-description = description.

  endmethod.


  method zif_otel_metric~set_unit.

    me->options-unit = unit.

  endmethod.


  method zif_otel_metric~set_double.

    me->options-value_type = zif_otel_metric=>value_types-double.

  endmethod.


  method constructor.

    me->name = name.
    me->options = options.
    me->type = type.

  endmethod.
ENDCLASS.
