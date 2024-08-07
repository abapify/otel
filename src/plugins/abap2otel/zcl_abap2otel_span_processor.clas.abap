class zcl_abap2otel_span_processor definition
inheriting from zcl_abap2otel_span_exporter
  public

  create public .

  public section.
    interfaces zif_otel_trace_processor.
  protected section.
  private section.

endclass.



class zcl_abap2otel_span_processor implementation.
  method zif_otel_trace_processor~on_span_end.
    me->add_span( span = cast #( span ) ).
  endmethod.
  method zif_otel_trace_processor~on_span_start.

  endmethod.

  method zif_otel_trace_processor~on_span_event.

  endmethod.

endclass.
