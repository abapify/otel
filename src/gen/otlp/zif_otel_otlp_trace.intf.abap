INTERFACE zif_otel_otlp_trace PUBLIC.

  TYPES:
    "! Status codes for spans
    status_code_type TYPE i,
    BEGIN OF status_code,
      unset TYPE status_code_type VALUE 0,
      ok    TYPE status_code_type VALUE 1,
      error TYPE status_code_type VALUE 2,
    END OF status_code.

  TYPES:
    "! Span kinds
    span_kind_type TYPE i,
    BEGIN OF span_kind,
      unspecified TYPE span_kind_type VALUE 0,
      internal    TYPE span_kind_type VALUE 1,
      server      TYPE span_kind_type VALUE 2,
      client      TYPE span_kind_type VALUE 3,
      producer    TYPE span_kind_type VALUE 4,
      consumer    TYPE span_kind_type VALUE 5,
    END OF span_kind.

  TYPES:
    BEGIN OF status,
      message TYPE string,
      code    TYPE status_code_type,
    END OF status.

  TYPES:
    BEGIN OF event,
      time_unix_nano          TYPE int8,
      name                    TYPE string,
      attributes              TYPE zif_otel_otlp_common=>key_values,
      dropped_attributes_count TYPE i,
    END OF event.

  TYPES:
    events TYPE STANDARD TABLE OF event WITH EMPTY KEY.

  TYPES:
    BEGIN OF link,
      trace_id                TYPE xstring,
      span_id                 TYPE xstring,
      trace_state            TYPE string,
      attributes              TYPE zif_otel_otlp_common=>key_values,
      dropped_attributes_count TYPE i,
      flags                   TYPE i,
    END OF link.

  TYPES:
    links TYPE STANDARD TABLE OF link WITH EMPTY KEY.

  TYPES:
    BEGIN OF span,
      trace_id                TYPE xstring,
      span_id                 TYPE xstring,
      trace_state            TYPE string,
      parent_span_id         TYPE xstring,
      flags                   TYPE i,
      name                    TYPE string,
      kind                    TYPE span_kind_type,
      start_time_unix_nano   TYPE int8,
      end_time_unix_nano     TYPE int8,
      attributes              TYPE zif_otel_otlp_common=>key_values,
      dropped_attributes_count TYPE i,
      events                  TYPE events,
      dropped_events_count    TYPE i,
      links                   TYPE links,
      dropped_links_count     TYPE i,
      status                  TYPE status,
    END OF span.

  TYPES:
    spans TYPE STANDARD TABLE OF span WITH EMPTY KEY.

  TYPES:
    BEGIN OF scope_spans,
      scope       TYPE zif_otel_otlp_common=>instrumentation_scope,
      spans       TYPE spans,
      schema_url TYPE string,
    END OF scope_spans.

  TYPES:
    scope_spans_tab TYPE STANDARD TABLE OF scope_spans WITH EMPTY KEY.

  TYPES:
    BEGIN OF resource_spans,
      resource    TYPE zif_otel_otlp_resource=>resource,
      scope_spans TYPE scope_spans_tab,
      schema_url TYPE string,
    END OF resource_spans.

  TYPES:
    resource_spans_tab TYPE STANDARD TABLE OF resource_spans WITH EMPTY KEY.

  TYPES:
    BEGIN OF traces_data,
      resource_spans TYPE resource_spans_tab,
    END OF traces_data.

ENDINTERFACE.
