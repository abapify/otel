class zcl_otel_api definition
  public
  final
  abstract.

  public section.
  interfaces zif_otel_api.
  aliases traces for zif_otel_api~traces.
  aliases logs for zif_otel_api~logs.
  aliases metrics for zif_otel_api~metrics.
  protected section.
  private section.
ENDCLASS.



CLASS ZCL_OTEL_API IMPLEMENTATION.


  method zif_otel_api~logs.

    statics api type ref to zif_otel_logs_api.

    if api is not bound.

      data badi type ref to zotel_api_badi.

      get badi badi.

      call badi badi->zif_otel_api~logs
        receiving
          result = api.

    endif.

    result = api.

  endmethod.


  method zif_otel_api~metrics.

    statics api type ref to zif_otel_metrics_api.

    if api is not bound.

      data badi type ref to zotel_api_badi.

      get badi badi.

      call badi badi->zif_otel_api~metrics
        receiving
          result = api.

    endif.

    result = api.

  endmethod.


  method zif_otel_api~traces.

    statics api type ref to zif_otel_trace_api.

    if api is not bound.

      data badi type ref to zotel_api_badi.

      get badi badi.

      call badi badi->zif_otel_api~traces
        receiving
          result = api.

    endif.

    result = api.

  endmethod.
ENDCLASS.
