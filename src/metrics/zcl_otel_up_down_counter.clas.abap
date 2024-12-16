class zcl_otel_up_down_counter definition
  public
  final
  create public inheriting from zcl_otel_metric .

  public section.

   methods constructor importing
                          name    type string
                          options type zif_otel_metric~ts_metric_options optional.

  interfaces zif_otel_up_down_counter.
  protected section.

  private section.
endclass.



class zcl_otel_up_down_counter implementation.


  method constructor.

    super->constructor( type = zif_otel_metric_types=>up_down_counter name = name options = options ).

  endmethod.

endclass.
