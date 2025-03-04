INTERFACE zif_otel_otlp_trace PUBLIC.
* This file is generated by AI. Do not modify manually.

  TYPES:
    "! Status code type
    status_code_type TYPE i,

    "! Span kind type  
    span_kind_type TYPE i,

    "! Span flags type
    span_flags_type TYPE i.

  CONSTANTS:
    BEGIN OF status_code,
      unset TYPE status_code_type VALUE 0,
      ok    TYPE status_code_type VALUE 1,
      error TYPE status_code_type VALUE 2,
    END OF status_code,

    BEGIN OF span_kind,
      unspecified TYPE span_kind_type VALUE 0,
      internal    TYPE span_kind_type VALUE 1,
      server      TYPE span_kind_type VALUE 2,
      client      TYPE span_kind_type VALUE 3,
      producer    TYPE span_kind_type VALUE 4,
      consumer    TYPE span_kind_type VALUE 5,
    END OF span_kind,

    BEGIN OF span_flags,
      trace_flags_mask                TYPE span_flags_type VALUE 255,
      context_has_is_remote_mask     TYPE span_flags_type VALUE 256,
      context_is_remote_mask         TYPE span_flags_type VALUE 512,
    END OF span_flags.

  TYPES:
    "! Status information
    BEGIN OF status,
      message TYPE string,
      code    TYPE status_code_type,
    END OF status,

    "! Event attributes
    BEGIN OF event,
      time_unix_nano           TYPE int8,
      name                     TYPE string,
      attributes              TYPE zif_otel_otlp_common=>key_value_list_values,
      dropped_attributes_count TYPE i,
    END OF event,

    "! Table of events
    event_tab TYPE STANDARD TABLE OF event WITH EMPTY KEY,

    "! Link information
    BEGIN OF link,
      trace_id                 TYPE xstring,
      span_id                  TYPE xstring,
      trace_state             TYPE string,
      attributes              TYPE zif_otel_otlp_common=>key_value_list_values,
      dropped_attributes_count TYPE i,
      flags                   TYPE span_flags_type,
    END OF link,

    "! Table of links
    link_tab TYPE STANDARD TABLE OF link WITH EMPTY KEY,

    "! Span information
    BEGIN OF span,
      trace_id                 TYPE xstring,
      span_id                  TYPE xstring,
      trace_state             TYPE string,
      parent_span_id          TYPE xstring,
      name                     TYPE string,
      kind                     TYPE span_kind_type,
      start_time_unix_nano    TYPE int8,
      end_time_unix_nano      TYPE int8,
      attributes              TYPE zif_otel_otlp_common=>key_value_list_values,
      dropped_attributes_count TYPE i,
      events                  TYPE event_tab,
      dropped_events_count    TYPE i,
      links                   TYPE link_tab,
      dropped_links_count     TYPE i,
      status                  TYPE status,
      flags                   TYPE span_flags_type,
    END OF span,

    "! Table of spans
    span_tab TYPE STANDARD TABLE OF span WITH EMPTY KEY,

    "! Scope spans
    BEGIN OF scope_spans,
      scope       TYPE zif_otel_otlp_common=>instrumentation_scope,
      spans       TYPE span_tab,
      schema_url TYPE string,
    END OF scope_spans,

    "! Table of scope spans
    scope_spans_tab TYPE STANDARD TABLE OF scope_spans WITH EMPTY KEY,

    "! Resource spans
    BEGIN OF resource_spans,
      resource    TYPE zif_otel_otlp_resource=>resource,
      scope_spans TYPE scope_spans_tab,
      schema_url TYPE string,
    END OF resource_spans,

    "! Table of resource spans
    resource_spans_tab TYPE STANDARD TABLE OF resource_spans WITH EMPTY KEY,

    "! Traces data
    BEGIN OF traces_data,
      resource_spans TYPE resource_spans_tab,
    END OF traces_data.

ENDINTERFACE.
