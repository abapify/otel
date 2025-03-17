interface ZIF_OTEL_TASK_TRACER
  public .


  methods EXECUTE_TASK
    importing
      !TASK type ref to ZIF_OTEL_TRACEABLE_TASK
    raising
      CX_STATIC_CHECK .
endinterface.
