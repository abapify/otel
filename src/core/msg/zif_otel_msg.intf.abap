interface ZIF_OTEL_MSG
  public .


  methods GET_BINARY
    returning
      value(RESULT) type XSTRING .
  methods CONTENT_TYPE
    returning
      value(CONTENT_TYPE) type STRING .
endinterface.
