class zcl_otel_logs_api definition
  public
  final
  create private
  global friends zcl_otel_api_manager.

  public section.

    interfaces zif_otel_logs_api_manager.

  protected section.
  private section.

    data:
      processors type table of ref to zif_otel_logs_processor with empty key ,
      logger_provider type ref to zif_otel_logger_provider.

    methods on_log_record_added for event log_record_added of zcl_otel_logger_provider
        importing logger log_record.

endclass.

class zcl_otel_logs_api implementation.

  method zif_otel_logs_api_manager~use.
    append processor to processors.
  endmethod.

  method on_log_record_added.

    loop at processors into data(processor).

        processor->on_log_record_added(
          logger     = logger
          log_record = log_record
        ).

    endloop.

  endmethod.

  method zif_otel_logs_api~get_logger.
    result = me->zif_otel_logs_api~get_logger_provider( )->get_logger( name ).
  endmethod.

  method zif_otel_logs_api~get_logger_provider.

    if me->logger_provider is not bound.
      data(logger_provider) = new zcl_otel_logger_provider( ).
      set handler on_log_record_added for logger_provider.
      me->logger_provider = logger_provider.
    endif.

    result = me->logger_provider.

  endmethod.

endclass.
