interface ZIF_OTEL_TASK_TRACER
  public .


  methods EXECUTE_TASK
    importing
      !TASK type ref to ZIF_OTEL_TRACEABLE_TASK
      !DEFAULT_CONTEXT type ABAP_BOOL optional
    raising
      CX_STATIC_CHECK .
endinterface.
