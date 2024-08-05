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
endclass.



class zcl_otel_api implementation.
  method zif_otel_api~logs.

    data api type ref to zotel_api_badi.

    get badi api.

    call badi api->zif_otel_api~logs
      receiving
        result = result
      .

  endmethod.

  method zif_otel_api~metrics.

    data api type ref to zotel_api_badi.

    get badi api.

    call badi api->zif_otel_api~metrics
      receiving
        result = result
      .

  endmethod.

  method zif_otel_api~traces.

    data api type ref to zotel_api_badi.

    get badi api.

    call badi api->zif_otel_api~traces
      receiving
        result = result
      .

  endmethod.

endclass.
