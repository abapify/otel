interface zif_otel_api
  public .
  class-methods traces  returning value(result) type ref to zif_otel_trace_api
                        raising
                                  cx_static_check..
  class-methods logs    returning value(result) type ref to zif_otel_logs_api
                        raising
                                  cx_static_check.
  class-methods metrics returning value(result) type ref to zif_otel_metrics_api
                        raising
                                  cx_static_check..

endinterface.
