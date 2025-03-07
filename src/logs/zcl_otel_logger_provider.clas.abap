"! OpenTelemetry Logger Provider Implementation
"! Manages and provides instances of loggers and emits log events.
class zcl_otel_logger_provider definition
  public
  final
  create private
  global friends zcl_otel_logs_api.

  public section.
    interfaces zif_otel_logger_provider.

  private section.
    types:
      begin of logger_entry,
        name   type string,
        logger type ref to zif_otel_logger,
      end of logger_entry.

    data loggers type hashed table of logger_entry with unique key name.

    "! Forwards log record events from individual loggers to the provider.
    methods on_log_record_added
      for event log_record_added of zcl_otel_logger
      importing
        sender
        record
      .

    "! Event triggered when a log record is added.
    events log_record_added
      exporting
        value(logger) type ref to zif_otel_logger
        value(log_record) type ref to zif_otel_log_record.

endclass.

class zcl_otel_logger_provider implementation.

  method zif_otel_logger_provider~get_logger.
    try.
        result = me->loggers[ name = name ]-logger.
      catch cx_sy_itab_line_not_found.
        data(new_logger) = new zcl_otel_logger( name ).
        set handler me->on_log_record_added for new_logger.
        insert value #( name = name logger = new_logger ) into table me->loggers.
        result = new_logger.
    endtry.
  endmethod.

  method on_log_record_added.
    raise event log_record_added exporting logger = sender log_record = record.
  endmethod.

endclass.

