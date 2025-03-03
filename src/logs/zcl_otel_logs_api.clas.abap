class ZCL_OTEL_LOGS_API definition
  public
  final
  create private .

public section.

  interfaces ZIF_OTEL_LOGGER_PROVIDER .
  interfaces ZIF_OTEL_LOGS_API .

  class-data API type ref to ZIF_OTEL_LOGS_API read-only .
  class-data APP type ref to ZCL_OTEL_LOGS_API .

  methods USE
    importing
      !PROCESSOR type ref to ZIF_OTEL_LOGS_PROCESSOR .
  class-methods CLASS_CONSTRUCTOR .
  methods CONSTRUCTOR .
  PRIVATE SECTION.
    DATA logger_provider TYPE REF TO zcl_otel_logger_provider.
    DATA processors TYPE TABLE OF REF TO zif_otel_logs_processor WITH EMPTY KEY.

    METHODS on_log_record_added FOR EVENT log_record_added OF zcl_otel_logger_provider
      IMPORTING logger record.
ENDCLASS.



CLASS ZCL_OTEL_LOGS_API IMPLEMENTATION.


  METHOD on_log_record_added.
    LOOP AT me->processors INTO DATA(lo_processor).
      CHECK lo_processor IS BOUND.
      lo_processor->on_log_record_added(
        logger = logger
        record = record
      ).
    ENDLOOP.
  ENDMETHOD.


  METHOD use.
    CHECK processor IS BOUND.
    APPEND processor TO me->processors.
  ENDMETHOD.


  METHOD class_constructor.
    DATA(this) = NEW zcl_otel_logs_api( ).
    app = this.
    api = this.
  ENDMETHOD.


  METHOD zif_otel_logger_provider~get_logger.

    result = me->logger_provider->zif_otel_logger_provider~get_logger( name = name ).

  ENDMETHOD.


  METHOD constructor.

    super->constructor( ).

    me->logger_provider = new #( ).

    set handler on_log_record_added for me->logger_provider.


  ENDMETHOD.
ENDCLASS.
