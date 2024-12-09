class zcl_otel_meter definition
  public
  final
  create private
  global friends zcl_otel_meter_provider .

  public section.
    interfaces zif_otel_meter.

    methods constructor
    importing name type string.
  protected section.
  private section.
    DATA name TYPE string.

    methods register_metric importing metric type ref to zcl_otel_metric.
    methods on_metric_value_added for event value_added of zcl_otel_metric
      importing
        sender
        data_point.

    events metric_value_added
      exporting
        value(metric)     type ref to zif_otel_metric
        value(data_point) type ref to zif_otel_data_point.

endclass.



class zcl_otel_meter implementation.

  method zif_otel_meter~create_counter.

    counter = new zcl_otel_counter(
    name = name
    options = options ).

  endmethod.

  method zif_otel_meter~create_gauge.

    gauge = new zcl_otel_gauge(
  name = name
  options = options ).

  endmethod.

  method zif_otel_meter~create_histogram.

    histogram = new zcl_otel_histogram(
  name = name
  options = options ).

  endmethod.

  method zif_otel_meter~create_up_down_counter.

    counter = new zcl_otel_up_down_counter(
  name = name
  options = options ).

  endmethod.

  method register_metric.

    set handler on_metric_value_added for metric.

  endmethod.

  method on_metric_value_added.

    raise event metric_value_added
       exporting
          metric = sender
          data_point = data_point.

  endmethod.

  method constructor.

  me->name = name.

  endmethod.

endclass.
