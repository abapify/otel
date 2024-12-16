class zcl_otel_counter definition
  public
  final
  create public inheriting from zcl_otel_metric .

  public section.

   methods constructor importing
                          name    type string
                          options type zif_otel_metric~ts_metric_options optional.

  interfaces zif_otel_counter.
  protected section.

  private section.
endclass.

class zcl_otel_counter implementation.


  method constructor.

    super->constructor( type = zif_otel_metric_types=>counter name = name options = options ).

  endmethod.

endclass.
