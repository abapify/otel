interface ZIF_OTEL_METRIC_PROCESSOR
  public .


  methods ADD_METRIC
    importing
      !METRIC type ZCL_ABAP2OTEL_MSG=>METRIC_TS .
endinterface.
