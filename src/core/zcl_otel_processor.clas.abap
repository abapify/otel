class zcl_otel_processor definition
  public

  create public .

  public section.
    interfaces zif_otel_processor.
    methods constructor importing collector type ref to zif_otel_collector.
  protected section.
  private section.
    data collector type ref to zif_otel_collector.
endclass.



class zcl_otel_processor implementation.
  method zif_otel_logs_processor~on_log_record_added.

    me->collector->add_log(
      logger     = logger
      log_record = log_record
    ).

  endmethod.

  method zif_otel_metrics_processor~on_metric_value_added.

    me->collector->add_metric(
      meter      = meter
      metric     = metric
      data_point = data_point
    ).

  endmethod.

  method zif_otel_trace_processor~on_span_end.

    me->collector->add_trace(
      tracer = tracer
      span   = span
    ).

  endmethod.

  method zif_otel_trace_processor~on_span_event.

  endmethod.

  method zif_otel_trace_processor~on_span_start.

  endmethod.

  method constructor.
    me->collector = cond #( when collector is bound then collector else new lcl_noop_collector( ) ).

  endmethod.

endclass.
