INTERFACE zif_otel_otlp_trace PUBLIC.
* Generated by AI - do not maintain manually
* Based on opentelemetry/proto/trace/v1/trace.proto

  TYPES:
    "! Status code enum type
    status_code_type TYPE i,

    "! Span kind enum type  
    span_kind_type TYPE i,

    "! Span flags enum type
    span_flags_type TYPE i.

  CONSTANTS:
    "! Status code enum values
    BEGIN OF status_code,
      unset TYPE status_code_type VALUE 0,
      ok    TYPE status_code_type VALUE 1,
      error TYPE status_code_type VALUE 2,
    END OF status_code,

    "! Span kind enum values 
    BEGIN OF span_kind,
      unspecified TYPE span_kind_type VALUE 0,
      internal    TYPE span_kind_type VALUE 1,
      server      TYPE span_kind_type VALUE 2,
      client      TYPE span_kind_type VALUE 3,
      producer    TYPE span_kind_type VALUE 4,
      consumer    TYPE span_kind_type VALUE 5,
    END OF span_kind,

    "! Span flags enum values
    BEGIN OF span_flags,
      do_not_use                      TYPE span_flags_type VALUE 0,
      trace_flags_mask                TYPE span_flags_type VALUE 255,
      context_has_is_remote_mask      TYPE span_flags_type VALUE 256,
      context_is_remote_mask          TYPE span_flags_type VALUE 512,
    END OF span_flags.

  TYPES:
    "! Status represents the status of a span
    BEGIN OF status,
      message TYPE string,
      code    TYPE status_code_type,
    END OF status,

    "! Link represents a link between spans
    BEGIN OF link,
      trace_id                TYPE string,
      span_id                 TYPE string,
      trace_state            TYPE string,
      attributes             TYPE STANDARD TABLE OF zif_otel_otlp_common=>key_value WITH EMPTY KEY,
      dropped_attributes_count TYPE i,
      flags                  TYPE i,
    END OF link,

    "! Table type for links
    tt_link TYPE STANDARD TABLE OF link WITH EMPTY KEY,

    "! Event represents a time-stamped event
    BEGIN OF event,
      time_unix_nano         TYPE string,
      name                   TYPE string,
      attributes             TYPE STANDARD TABLE OF zif_otel_otlp_common=>key_value WITH EMPTY KEY,
      dropped_attributes_count TYPE i,
    END OF event,

    "! Table type for events
    tt_event TYPE STANDARD TABLE OF event WITH EMPTY KEY,

    "! Span represents a single operation within a trace
    BEGIN OF span,
      trace_id               TYPE string,
      span_id                TYPE string,
      trace_state           TYPE string,
      parent_span_id        TYPE string,
      flags                 TYPE i,
      name                  TYPE string,
      kind                  TYPE span_kind_type,
      start_time_unix_nano  TYPE string,
      end_time_unix_nano    TYPE string,
      attributes            TYPE STANDARD TABLE OF zif_otel_otlp_common=>key_value WITH EMPTY KEY,
      dropped_attributes_count TYPE i,
      events                TYPE tt_event,
      dropped_events_count  TYPE i,
      links                 TYPE tt_link,
      dropped_links_count   TYPE i,
      status               TYPE status,
    END OF span,

    "! Table type for spans
    tt_span TYPE STANDARD TABLE OF span WITH EMPTY KEY,

    "! ScopeSpans represents spans from a single instrumentation scope
    BEGIN OF scope_spans,
      scope      TYPE zif_otel_otlp_common=>instrumentation_scope,
      spans      TYPE tt_span,
      schema_url TYPE string,
    END OF scope_spans,

    "! Table type for scope_spans
    tt_scope_spans TYPE STANDARD TABLE OF scope_spans WITH EMPTY KEY,

    "! ResourceSpans represents spans from a single resource
    BEGIN OF resource_spans,
      resource   TYPE zif_otel_otlp_resource=>resource,
      scope_spans TYPE tt_scope_spans,
      schema_url TYPE string,
    END OF resource_spans,

    "! Table type for resource_spans
    tt_resource_spans TYPE STANDARD TABLE OF resource_spans WITH EMPTY KEY,

    "! TracesData represents the traces data that can be stored in a persistent storage
    BEGIN OF traces_data,
      resource_spans TYPE tt_resource_spans,
    END OF traces_data.

ENDINTERFACE.
