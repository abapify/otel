class zcl_otel_trace_processor definition
  public
  create protected .

  public section.
  interfaces zif_otel_trace_processor.
  interfaces zif_otel_cx_proxy.
  protected section.
  methods throw_cx importing cx type ref to cx_root.
  private section.
endclass.



class zcl_otel_trace_processor implementation.
  method zif_otel_trace_processor~on_span_end.

  endmethod.

  method zif_otel_trace_processor~on_span_event.

  endmethod.

  method zif_otel_trace_processor~on_span_start.

  endmethod.

  method throw_cx.

    raise event zif_otel_cx_proxy~cx
      exporting
        cx     = cx
      .

  endmethod.

endclass.
