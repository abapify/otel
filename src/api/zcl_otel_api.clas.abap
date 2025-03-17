class zcl_otel_api definition
  public
  final
  abstract.

  public section.

    class-methods traces importing scenario type string optional returning value(result) type ref to zif_otel_trace_api.
    class-methods logs importing scenario type string optional returning value(result) type ref to zif_otel_logs_api.
    class-methods metrics importing scenario type string optional returning value(result) type ref to zif_otel_metrics_api.

  protected section.
  private section.

ENDCLASS.



CLASS ZCL_OTEL_API IMPLEMENTATION.


  method logs.

    result = zcl_otel=>api( scenario )->logs( ).

  endmethod.


  method metrics.

    result = zcl_otel=>api( scenario )->metrics( ).

  endmethod.


  method traces.

   result = zcl_otel=>api( scenario )->trace( ).

  endmethod.
ENDCLASS.
