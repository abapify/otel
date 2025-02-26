interface zif_otel_msg_buffer
  public .

  interfaces zif_otel_msg.

  methods clear.
  methods size returning value(result) type i.
  events updated.


endinterface.
