class zcl_otel_api_badi_fallback definition
  public
  final
  create public .

  public section.
    interfaces zif_otel_api_badi.
  protected section.
  private section.
    class-methods throw importing message type string raising cx_static_check.
endclass.



class zcl_otel_api_badi_fallback implementation.



  method zif_otel_api~logs.
    throw( 'Logs API is not implemented. Please create ZOTEL_API_BADI implementation.' ).
  endmethod.

  method zif_otel_api~metrics.
    throw( 'Metrcis API is not implemented. Please create ZOTEL_API_BADI implementation.' ).
  endmethod.

  method zif_otel_api~traces.
    result = zcl_otel_trace=>api.
  endmethod.

  method throw.
    new zcl_throw( )->throw( message ).
  endmethod.

endclass.
