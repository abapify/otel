class zcl_abap2otel_exporter_http definition
  public
  inheriting from zcl_abap2otel_span_processor
  final
  create public .

  public section.

    types headers_type type zif_fetch_entity=>header_tt.
    methods constructor
      importing
        destination type ref to zif_fetch_destination
        batch_size  type i optional.

    data exporter type ref to zcl_otel_http_exporter read-only.

  protected section.
  private section.
endclass.

class zcl_abap2otel_exporter_http implementation.
  method constructor.
    data(exporter) = new zcl_otel_http_exporter( destination ).
    super->constructor( exporter = exporter batch_size = batch_size ).
    me->exporter = exporter.
  endmethod.
endclass.
