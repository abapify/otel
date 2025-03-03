"! OpenTelemetry Logger Implementation
"! Provides structured logging capabilities.
class zcl_otel_logger definition
  public
  final
  create private
  global friends zcl_otel_logger_provider zcl_otel_logs_api.

  public section.
    interfaces zif_otel_logger.

    methods constructor importing name type string optional.

  private section.
    aliases name for zif_otel_logger~name.

    events log_record_added
      exporting value(record) type ref to zif_otel_log_record.

ENDCLASS.



CLASS ZCL_OTEL_LOGGER IMPLEMENTATION.


  method zif_otel_logger~emit.
    raise event log_record_added exporting record = record.
  endmethod.


  method constructor.
    me->name = name.
  endmethod.


  method zif_otel_loggable~log.

    " this is important - otherwise we may loose data when
    data body_ref type ref to data.
    create data body_ref like body.
    assign body_ref->* to field-symbol(<body>).
    <body> = body.

    data(record) = new zcl_otel_log_record(
      severity   = severity
      body       = body_ref
      attributes = attributes
      context    = context
      timestamp  = timestamp
    ).

    me->zif_otel_logger~emit( record ).

  endmethod.
ENDCLASS.
