interface ZIF_OTEL_TRACEABLE
  public .


  methods TRACE
    returning
      value(RESULT) type ref to ZIF_OTEL_SPAN .
endinterface.
