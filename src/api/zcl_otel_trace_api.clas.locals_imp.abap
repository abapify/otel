*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

class lcl_noop_span definition.
  public section.
  interfaces zif_otel_span.
endclass.

CLASS lcl_noop_span IMPLEMENTATION.
  METHOD zif_otel_span~end.
  ENDMETHOD.
  METHOD zif_otel_span~fail.
  ENDMETHOD.
  METHOD zif_otel_span~log.
  ENDMETHOD.
  METHOD zif_otel_span~link.
  ENDMETHOD.
ENDCLASS.

class lcl_noop_tracer definition.
  public section.
  interfaces zif_otel_tracer.
endclass.

class lcl_noop_tracer implementation.
  method zif_otel_tracer~start_span.
    result = new lcl_noop_span( ).
  endmethod.
endclass.
