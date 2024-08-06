class ZCL_ABAP2OTEL_EXPORTER_HTTP definition
  public
  inheriting from ZCL_ABAP2OTEL_SPAN_PROCESSOR
  create public .

public section.

  types HEADERS_TYPE type ZIF_FETCH_ENTITY=>HEADER_TT .

  data EXPORTER type ref to ZCL_OTEL_HTTP_EXPORTER read-only .

  methods CONSTRUCTOR
    importing
      !DESTINATION type ref to ZIF_FETCH_DESTINATION
      !BATCH_SIZE type I optional .
  protected section.
  private section.
ENDCLASS.



CLASS ZCL_ABAP2OTEL_EXPORTER_HTTP IMPLEMENTATION.


  method constructor.
    data(exporter) = new zcl_otel_http_exporter( destination ).
    super->constructor( exporter = exporter batch_size = batch_size ).
    me->exporter = exporter.
  endmethod.
ENDCLASS.
