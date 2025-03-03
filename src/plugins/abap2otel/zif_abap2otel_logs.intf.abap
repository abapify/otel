"! ABAP2OTEL Logs Format Interface
"! Defines a lightweight, JSON-compatible structure for individual log records.
interface zif_abap2otel_logs public.

  types:

    begin of log_record_ts,
      attrs type zif_otel_attribute_map=>entries_tt,
      " body should be type ref to data,
      " we want to be able to export also data as Object/Arrays, not as JSON to avoid JSON-in-JSON pattern
      body type ref to data,
      ts   type xsddatetime_long_z,
      severity type string,
      trace_id type string,
      span_id  type string,
    end of log_record_ts.

endinterface.
