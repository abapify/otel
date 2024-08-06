interface ZIF_OTEL_TRACEABLE_TASK
  public .


    " execute with trace
  methods EXECUTE
    importing
      !SPAN type ref to ZIF_OTEL_SPAN
    raising
      CX_STATIC_CHECK .
  methods SPAN_NAME
    returning
      value(SPAN_NAME) type STRING .
endinterface.
