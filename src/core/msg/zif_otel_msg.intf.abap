interface zif_otel_msg
  public .

  methods GET_BINARY
    returning
      value(RESULT) type XSTRING .

  methods content_type
    returning value(content_type) type string.

endinterface.
