class ZCL_OTEL_API_BADI_FALLBACK definition
  public
  create public .

public section.

  interfaces IF_BADI_INTERFACE .
  interfaces ZIF_OTEL_API .
  interfaces ZIF_OTEL_API_BADI .
  protected section.
  private section.
    class-methods throw importing message type string raising cx_static_check.
ENDCLASS.



CLASS ZCL_OTEL_API_BADI_FALLBACK IMPLEMENTATION.


  method throw.
    new zcl_throw( )->throw( message ).
  endmethod.


  method zif_otel_api~logs.
    throw( 'Logs API is not implemented. Please create ZOTEL_API_BADI implementation.' ).
  endmethod.


  method zif_otel_api~metrics.
    throw( 'Metrcis API is not implemented. Please create ZOTEL_API_BADI implementation.' ).
  endmethod.


  method zif_otel_api~traces.
    throw( 'Trace API is not implemented. Please create ZOTEL_API_BADI implementation.' ).
  endmethod.
ENDCLASS.
