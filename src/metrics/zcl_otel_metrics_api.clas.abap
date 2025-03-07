class zcl_otel_metrics_api definition
  public
  final
  create private
  global friends zcl_otel_api_manager.

  public section.

    interfaces zif_otel_metrics_api_manager.
    interfaces zif_otel_metrics_api.

  protected section.
  private section.

    data:
      processors type table of ref to zif_otel_metrics_processor with empty key .
    data meter_provider type ref to zif_otel_meter_provider.

    methods on_metric_value_added for event metric_value_added of zcl_otel_meter_provider
      importing
        data_point
        meter
        metric
      .

endclass.

class zcl_otel_metrics_api implementation.

  method zif_otel_metrics_api_manager~use.
    append processor to processors.
  endmethod.

  method on_metric_value_added.

    loop at processors into data(processor).

      processor->on_metric_value_added(
        meter      = meter
        metric     = metric
        data_point = data_point
      ).

    endloop.

  endmethod.

  method zif_otel_metrics_api~get_meter.

    meter = me->zif_otel_metrics_api~get_meter_provider( )->get_meter( name ).

  endmethod.

  method zif_otel_metrics_api~get_meter_provider.

    if me->meter_provider is not bound.
      data(meter_provider) = new zcl_otel_meter_provider( ).
      set handler on_metric_value_added for meter_provider.
      me->meter_provider = meter_provider.
    endif.

    provider = me->meter_provider.

  endmethod.


endclass.
