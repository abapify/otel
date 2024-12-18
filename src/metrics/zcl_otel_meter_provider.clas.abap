class zcl_otel_meter_provider definition
  public
  final
  create private
  global friends zcl_otel_metrics_api.

  public section.
    interfaces zif_otel_meter_provider.
  protected section.
  private section.

    types:
      begin of meters_ts,
        name  type string,
        meter type ref to zif_otel_meter,
      end of meters_ts.

    data meters type hashed table of meters_ts with unique key name.

    methods on_metric_value_added for event metric_value_added of zcl_otel_meter
      importing
        sender
        metric
        data_point.

    events metric_value_added
      exporting
        value(meter)      type ref to zif_otel_meter
        value(metric)     type ref to zif_otel_metric
        value(data_point) type ref to zif_otel_data_point.

endclass.



class zcl_otel_meter_provider implementation.
  method zif_otel_meter_provider~get_meter.

    " it should persist meters map according to the spec

    try.
        meter = me->meters[  name = name ]-meter.

      catch cx_sy_itab_line_not_found.

        data(new_meter) = new zcl_otel_meter( name ).

        set handler on_metric_value_added for new_meter.

        insert value #( name = name meter = meter ) into table me->meters.

        meter = new_meter.
    endtry.

  endmethod.

  method on_metric_value_added.

    raise event  metric_value_added
     exporting
       data_point = data_point
       metric = metric
       meter = sender.

  endmethod.

endclass.
