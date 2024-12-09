class zcl_otel_metric definition
  public

  create public abstract
  global friends zcl_otel_meter.

  public section.
    interfaces zif_otel_metric.
    methods constructor importing
                          name    type string
                          options type zif_otel_metric~ts_metric_options optional.
  protected section.
  private section.

    data options type zif_otel_metric~ts_metric_options.
    data name type string.
    events value_added exporting
                         value(data_point) type ref to zif_otel_data_point.

endclass.



class zcl_otel_metric implementation.
  method zif_otel_metric~add_value.


    data(data_point) = new zcl_otel_data_point(
      value = value
      context = context
      attributes = attributes ).

    raise event value_added exporting data_point = data_point.

  endmethod.

  method zif_otel_metric~set_description.

    me->options-description = description.

  endmethod.

  method zif_otel_metric~set_unit.

    me->options-unit = unit.

  endmethod.

  method zif_otel_metric~set_double.

    me->options-value_type = zif_otel_metric=>double.

  endmethod.

  method constructor.

    me->name = name.
    me->options = options.

  endmethod.

endclass.
