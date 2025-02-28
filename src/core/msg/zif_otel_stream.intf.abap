interface ZIF_OTEL_STREAM
  public .


  methods PUBLISH
    importing
      !MESSAGE type ref to ZIF_OTEL_MSG
    raising
      CX_STATIC_CHECK .
endinterface.
