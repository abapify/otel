*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

class lcl_noop_span definition.
  public section.
    interfaces zif_otel_span.
    interfaces zif_otel_attribute_map.
    interfaces zif_otel_attribute.
endclass.

class lcl_noop_span implementation.
  method zif_otel_span~end.
  endmethod.
  method zif_otel_span~fail.
  endmethod.
  method zif_otel_span~log.
  endmethod.
  method zif_otel_span~link.
  endmethod.
  method zif_otel_has_attributes~attributes.
    result = me.
  endmethod.
  method zif_otel_attribute_map~attribute.
    result = me.
  endmethod.
  method zif_otel_attribute_map~values.
  endmethod.
  method zif_otel_attribute_map~entries.
  endmethod.
  method zif_otel_attribute_map~append.
  endmethod.
  method zif_otel_attribute~get.
  endmethod.
  method zif_otel_attribute~set.
  endmethod.
  method zif_otel_attribute~set_getter.
  endmethod.
  method zif_otel_span_context~get_context.
  endmethod.
endclass.

class lcl_noop_tracer definition.
  public section.
    interfaces zif_otel_tracer.
endclass.

class lcl_noop_tracer implementation.
  method zif_otel_tracer~start_span.
    result = new lcl_noop_span( ).
  endmethod.
endclass.
