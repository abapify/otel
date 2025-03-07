class zcl_otel_api_manager definition
  public
  create private
  global friends zcl_otel_api_badi_base.

  public section.

    interfaces zif_otel_api_manager.
    interfaces zif_otel_api.

    methods constructor.

  protected section.

  private section.

    data trace type ref to zcl_otel_trace_api.
    data logs type ref to zcl_otel_logs_api.
    data metrics type ref to zcl_otel_metrics_api.


endclass.

class zcl_otel_api_manager implementation.

  method constructor.

    trace = new #(  ).
    logs = new #(  ).
    metrics  = new #(  ).

  endmethod.

  method zif_otel_api~logs.

    result = me->logs.

  endmethod.

  method zif_otel_api~metrics.

    result = me->metrics.

  endmethod.

  method zif_otel_api~trace.

    result = me->trace.

  endmethod.

  method zif_otel_api_manager~logs.

    result = me->logs.

  endmethod.

  method zif_otel_api_manager~metrics.

    result = me->metrics.

  endmethod.

  method zif_otel_api_manager~trace.

    result = me->trace.

  endmethod.

endclass.
