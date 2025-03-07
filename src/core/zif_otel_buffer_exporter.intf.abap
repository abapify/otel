interface zif_otel_buffer_exporter
  public .

    methods subscribe importing buffer type ref to zif_otel_msg_buffer.

endinterface.
