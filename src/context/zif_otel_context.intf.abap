INTERFACE zif_otel_context
  PUBLIC.

  
  data parent_context TYPE REF TO zif_otel_context READ-ONLY.
  data root_context type ref to zif_otel_context read-only.

  TYPES:
    BEGIN OF ts_context_entry,
      key   TYPE string,
      value TYPE REF TO data,
    END OF ts_context_entry,
    tt_context_entries TYPE STANDARD TABLE OF ts_context_entry WITH KEY key.

  METHODS:
    get_value
      IMPORTING
        key         TYPE string
      RETURNING
        VALUE(value) TYPE REF TO data,

    set_value
      IMPORTING
        key           TYPE string
        value         TYPE any
      RETURNING
        VALUE(context) TYPE REF TO zif_otel_context,

    delete_value
      IMPORTING
        key           TYPE string
      RETURNING
        VALUE(context) TYPE REF TO zif_otel_context,

    get_entries
      RETURNING
        VALUE(entries) TYPE tt_context_entries.

ENDINTERFACE.