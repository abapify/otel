class zcl_otel_metrics_api definition
  public
  final
  create private .

  public section  .
    interfaces zif_otel_metrics_api.
    interfaces zif_otel_metrics_provider.

    class-data api type ref to zif_otel_metrics_api read-only.
    class-data app type ref to zif_otel_metrics_provider read-only.

    class-methods class_constructor.

  protected section.
  private section.
    data meter_provider type ref to zif_otel_meter_provider.
    data processors type table of ref to zif_otel_metrics_processor with empty key.
    methods on_metric_value_added for event metric_value_added of zcl_otel_meter_provider
      importing
        data_point
        meter
        metric
      .
endclass.



class zcl_otel_metrics_api implementation.
  method zif_otel_metrics_api~disable.

    set handler on_metric_value_added for all instances activation ' '.

  endmethod.

  method zif_otel_metrics_api~get_meter.

    meter = me->zif_otel_metrics_api~get_meter_provider( )->get_meter( name ).

  endmethod.

  method zif_otel_metrics_api~get_meter_provider.

    if me->meter_provider is not bound.
      data(meter_provider) = new zcl_otel_meter_provider( ).
      set handler on_metric_value_added for meter_provider.
      me->zif_otel_metrics_api~set_global_meter_provider( provider = meter_provider ).
    endif.

    provider = me->meter_provider.

  endmethod.

  method zif_otel_metrics_api~set_global_meter_provider.

    me->meter_provider = provider.

  endmethod.

  method on_metric_value_added.

    loop at me->processors into data(lo_processor).
      check lo_processor is bound.
      lo_processor->on_metric_value_added(
        meter      = meter
        metric     = metric
        data_point = data_point
      ).

    endloop.


  endmethod.

  method zif_otel_metrics_provider~use.

    check processor is bound.
    append processor to me->processors.

  endmethod.

  method class_constructor.


    data(this) =  new zcl_otel_metrics_api(  ).
    api = this.
    app = this.

  endmethod.

endclass.
