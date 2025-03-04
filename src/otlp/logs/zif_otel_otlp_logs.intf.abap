"! <p class="shorttext">OTLP Logs Interface</p>
"! Generated by AI - do not maintain manually
INTERFACE zif_otel_otlp_logs PUBLIC.

  TYPES:
    "! Severity number type
    severity_number_type TYPE i,

    "! Log record flags type
    log_record_flags_type TYPE i.

  CONSTANTS:
    BEGIN OF severity_number,
      unspecified TYPE severity_number_type VALUE 0,
      trace       TYPE severity_number_type VALUE 1,
      trace2      TYPE severity_number_type VALUE 2,
      trace3      TYPE severity_number_type VALUE 3,
      trace4      TYPE severity_number_type VALUE 4,
      debug       TYPE severity_number_type VALUE 5,
      debug2      TYPE severity_number_type VALUE 6,
      debug3      TYPE severity_number_type VALUE 7,
      debug4      TYPE severity_number_type VALUE 8,
      info        TYPE severity_number_type VALUE 9,
      info2       TYPE severity_number_type VALUE 10,
      info3       TYPE severity_number_type VALUE 11,
      info4       TYPE severity_number_type VALUE 12,
      warn        TYPE severity_number_type VALUE 13,
      warn2       TYPE severity_number_type VALUE 14,
      warn3       TYPE severity_number_type VALUE 15,
      warn4       TYPE severity_number_type VALUE 16,
      error       TYPE severity_number_type VALUE 17,
      error2      TYPE severity_number_type VALUE 18,
      error3      TYPE severity_number_type VALUE 19,
      error4      TYPE severity_number_type VALUE 20,
      fatal       TYPE severity_number_type VALUE 21,
      fatal2      TYPE severity_number_type VALUE 22,
      fatal3      TYPE severity_number_type VALUE 23,
      fatal4      TYPE severity_number_type VALUE 24,
    END OF severity_number,

    BEGIN OF log_record_flags,
      do_not_use           TYPE log_record_flags_type VALUE 0,
      trace_flags_mask     TYPE log_record_flags_type VALUE 255,  "0x000000FF
    END OF log_record_flags.

  TYPES:
    "! Log record
    BEGIN OF log_record,
      time_unix_nano           TYPE string,
      observed_time_unix_nano  TYPE string,
      severity_number          TYPE severity_number_type,
      severity_text           TYPE string,
      body                    TYPE zif_otel_otlp_common=>any_value,
      attributes             TYPE STANDARD TABLE OF zif_otel_otlp_common=>key_value WITH EMPTY KEY,
      dropped_attributes_count TYPE i,
      flags                   TYPE i,
      trace_id               TYPE string,
      span_id                TYPE string,
      event_name             TYPE string,
    END OF log_record,

    "! Scope logs
    BEGIN OF scope_logs,
      scope       TYPE zif_otel_otlp_common=>instrumentation_scope,
      log_records TYPE STANDARD TABLE OF log_record WITH EMPTY KEY,
      schema_url  TYPE string,
    END OF scope_logs,

    "! Resource logs
    BEGIN OF resource_logs,
      resource    TYPE zif_otel_otlp_resource=>resource,
      scope_logs  TYPE STANDARD TABLE OF scope_logs WITH EMPTY KEY,
      schema_url  TYPE string,
    END OF resource_logs,

    "! Logs data
    BEGIN OF logs_data,
      resource_logs TYPE STANDARD TABLE OF resource_logs WITH EMPTY KEY,
    END OF logs_data.

ENDINTERFACE.
