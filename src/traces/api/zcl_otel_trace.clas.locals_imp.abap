*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
class lcl_trace_processor definition.
  public section.
    interfaces zif_otel_trace_processor.
    interfaces zif_otel_trace_provider.
  private section.
    data processors type table of ref to zif_otel_trace_processor with empty key.
endclass.

class lcl_trace_processor implementation.
  method zif_otel_trace_provider~use.
    append processor to processors.
  endmethod.
  method zif_otel_trace_processor~on_span_start.
    loop at processors into data(processor).
      processor->on_span_start( span = span ).
    endloop.
  endmethod.
  method zif_otel_trace_processor~on_span_event.
    loop at processors into data(processor).
      processor->on_span_event( event = event ).
    endloop.
  endmethod.
  method zif_otel_trace_processor~on_span_end.
    loop at processors into data(processor).
      processor->on_span_end( span = span ).
    endloop.
  endmethod.
endclass.
