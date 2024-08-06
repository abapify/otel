interface zif_otel_stack
  public .
   methods push importing data type ref to data.
  methods pop returning value(data) type ref to data.
  methods last returning value(data) type ref to data.

endinterface.
