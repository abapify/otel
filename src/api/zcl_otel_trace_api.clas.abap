class ZCL_OTEL_TRACE_API definition
  public
  abstract
  final
  create public .

public section.

  class-methods START_SPAN
    importing
      !NAME type STRING
    returning
      value(RESULT) type ref to ZIF_OTEL_SPAN .
protected section.
private section.
ENDCLASS.



CLASS ZCL_OTEL_TRACE_API IMPLEMENTATION.


  method start_span.

    statics tracer type ref to zif_otel_tracer.

    if tracer is not bound.
      try.
          " if by some reason we cannot create a real tracer
          " we should create no operational dummy instance
          " to avoid possible dumps in a source code
          tracer = zcl_otel_api=>traces( )->get_tracer( ).
        catch cx_static_check.
          tracer = new lcl_noop_tracer( ).
      endtry.
    endif.

    result = tracer->start_span( name = name default_context = abap_true ).

  endmethod.
ENDCLASS.
