*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
class lcl_noop_collector definition.
public section.
interfaces zif_otel_collector.
endclass.

CLASS lcl_noop_collector IMPLEMENTATION.

  METHOD zif_otel_logs_collector~add_log.

  ENDMETHOD.

  METHOD zif_otel_metrics_collector~add_metric.

  ENDMETHOD.

  METHOD zif_otel_trace_collector~add_span.

  ENDMETHOD.

ENDCLASS.
