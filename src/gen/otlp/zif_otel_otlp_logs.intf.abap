INTERFACE zif_otel_otlp_logs PUBLIC.

  TYPES:
    severity_number_type TYPE i,
    BEGIN OF severity_number,
      trace   TYPE severity_number_type VALUE 1,
      trace2  TYPE severity_number_type VALUE 2,
      trace3  TYPE severity_number_type VALUE 3,
      trace4  TYPE severity_number_type VALUE 4,
      debug   TYPE severity_number_type VALUE 5,
      debug2  TYPE severity_number_type VALUE 6,
      debug3  TYPE severity_number_type VALUE 7,
      debug4  TYPE severity_number_type VALUE 8,
      info    TYPE severity_number_type VALUE 9,
      info2   TYPE severity_number_type VALUE 10,
      info3   TYPE severity_number_type VALUE 11,
      info4   TYPE severity_number_type VALUE 12,
      warn    TYPE severity_number_type VALUE 13,
      warn2   TYPE severity_number_type VALUE 14,
      warn3   TYPE severity_number_type VALUE 15,
      warn4   TYPE severity_number_type VALUE 16,
      error   TYPE severity_number_type VALUE 17,
      error2  TYPE severity_number_type VALUE 18,
      error3  TYPE severity_number_type VALUE 19,
      error4  TYPE severity_number_type VALUE 20,
      fatal   TYPE severity_number_type VALUE 21,
      fatal2  TYPE severity_number_type VALUE 22,
      fatal3  TYPE severity_number_type VALUE 23,
      fatal4  TYPE severity_number_type VALUE 24,
    END OF severity_number.

  TYPES:
    BEGIN OF log_record,
      time_unix_nano          TYPE int8,
      observed_time_unix_nano TYPE int8,
      severity_number         TYPE severity_number_type,
      severity_text          TYPE string,
      body                    TYPE zif_otel_otlp_common=>any_value,
      attributes              TYPE zif_otel_otlp_common=>key_values,
      dropped_attributes_count TYPE i,
      flags                   TYPE i,
      trace_id               TYPE xstring,
      span_id                TYPE xstring,
      event_name             TYPE string,
    END OF log_record.

  TYPES:
    log_records TYPE STANDARD TABLE OF log_record WITH EMPTY KEY.

  TYPES:
    BEGIN OF scope_logs,
      scope       TYPE zif_otel_otlp_common=>instrumentation_scope,
      log_records TYPE log_records,
      schema_url TYPE string,
    END OF scope_logs.

  TYPES:
    scope_logs_tab TYPE STANDARD TABLE OF scope_logs WITH EMPTY KEY.

  TYPES:
    BEGIN OF resource_logs,
      resource    TYPE zif_otel_otlp_resource=>resource,
      scope_logs TYPE scope_logs_tab,
      schema_url TYPE string,
    END OF resource_logs.

  TYPES:
    resource_logs_tab TYPE STANDARD TABLE OF resource_logs WITH EMPTY KEY.

  TYPES:
    BEGIN OF logs_data,
      resource_logs TYPE resource_logs_tab,
    END OF logs_data.

ENDINTERFACE.
