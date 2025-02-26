class ZCL_ABAP2OTEL_METRIC_PROCESSOR definition
  public
  inheriting from ZCL_ABAP2OTEL_EXPORTER
  final
  create public .

public section.

  interfaces ZIF_OTEL_METRIC_PROCESSOR .

  aliases ADD_METRIC
    for ZIF_OTEL_METRIC_PROCESSOR~ADD_METRIC .
protected section.
private section.
ENDCLASS.



CLASS ZCL_ABAP2OTEL_METRIC_PROCESSOR IMPLEMENTATION.


  METHOD zif_otel_metric_processor~add_metric.
*    CHECK me->buffer IS BOUND
    IF me->buffer IS NOT BOUND.
       me->get_buffer(  ).
    ENDIF.

    me->buffer->add_metric(  metric  ).
  ENDMETHOD.
ENDCLASS.
