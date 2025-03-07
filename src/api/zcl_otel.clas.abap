class zcl_otel definition
  public
  final abstract
  create public .

  public section.

    types scenario_type type string.
    class-methods api importing scenario      type scenario_type optional
                      returning value(result) type ref to zif_otel_api.

  protected section.
  private section.

    types:
      begin of cache_ts,
        scenario type scenario_type,
        api      type ref to zif_otel_api,
      end of cache_ts.

    class-data cache type hashed table of cache_ts with unique key scenario.

endclass.

class zcl_otel implementation.
  method api.

    try.
        result = cache[ scenario = scenario ]-api .

      catch cx_sy_itab_line_not_found.

        data badi type ref to zotel_api_badi.

        get badi badi
          filters
            scenario = scenario.

        call badi
          badi->api
          receiving
            result = result.

       insert value #( scenario = scenario api = result ) into table cache.

    endtry.
  endmethod.

endclass.
