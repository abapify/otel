class zcl_abap2otel_exporter_http definition
  public
  inheriting from zcl_abap2otel_exporter
  create public .

  public section.

    types headers_type type zif_fetch_entity=>header_tt .

    data exporter type ref to zcl_otel_http_exporter read-only .

    methods constructor
      importing
        !destination type ref to zif_fetch_destination
        !batch_size  type i optional .
  protected section.
  private section.
endclass.

class zcl_abap2otel_exporter_http implementation.
  method constructor.
    data(exporter) = new zcl_otel_http_exporter( destination ).
    super->constructor( message_bus = exporter batch_size = batch_size ).
    me->exporter = exporter.
  endmethod.
endclass.
