class zcl_abap2otel_span_exporter definition inheriting from zcl_abap2otel_exporter

  public

  create public .

  public section.

    interfaces zif_otel_span_collector.
    aliases add_span for zif_otel_span_collector~add_span.

  protected section.

  private section.

endclass.

class zcl_abap2otel_span_exporter implementation.

  method zif_otel_span_collector~add_span.
    check me->buffer is bound.
    me->buffer->add_span( span->span_data ).
  endmethod.
endclass.
