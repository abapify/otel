interface ZIF_OTEL_PUBLISHER
  public .


  interfaces ZIF_OTEL_MSG_BUS .

  aliases PUBLISH
    for ZIF_OTEL_MSG_BUS~PUBLISH .

  methods START .
  methods STOP .
endinterface.
