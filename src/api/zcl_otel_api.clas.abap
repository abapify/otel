class zcl_otel_api definition
  public
  final
  abstract.

  public section.

    class-methods traces returning value(result) type ref to zif_otel_trace_api.
    class-methods logs returning value(result) type ref to zif_otel_logs_api.
    class-methods metrics returning value(result) type ref to zif_otel_metrics_api.

  protected section.
  private section.

endclass.

class zcl_otel_api implementation.
  method logs.

    result = zcl_otel=>api( )->logs( ).

  endmethod.

  method metrics.

    result = zcl_otel=>api( )->metrics( ).

  endmethod.

  method traces.

   result = zcl_otel=>api( )->trace( ).

  endmethod.

endclass.
