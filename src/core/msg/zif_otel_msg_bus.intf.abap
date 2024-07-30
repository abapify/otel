interface zif_otel_msg_bus
  public .

  methods publish importing message type ref to zif_otel_msg
                  RAISING
                    cx_static_check.

endinterface.
