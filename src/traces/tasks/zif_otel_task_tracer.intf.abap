interface zif_otel_task_tracer
  public .
  methods execute_task
    importing task type ref to zif_otel_traceable_task
    raising   cx_static_check
    .
endinterface.
