class zcl_otel_histogram definition
  public
  final
  create public inheriting from zcl_otel_metric .

  public section.

   methods constructor importing
                          name    type string
                          options type zif_otel_metric~ts_metric_options optional.

  interfaces zif_otel_histogram.
  protected section.

  private section.
endclass.



class zcl_otel_histogram implementation.


  method constructor.

    super->constructor( type = zif_otel_metric_types=>histogram name = name options = options ).

  endmethod.

endclass.
