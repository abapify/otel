CLASS zcl_otel_histogram DEFINITION
  PUBLIC
  INHERITING FROM zcl_otel_metric
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES zif_otel_histogram.

  PRIVATE SECTION.
    TYPES: BEGIN OF ts_bucket,
             upper_bound TYPE zif_otel_metric=>tv_value,
             count      TYPE i,
           END OF ts_bucket.
    
    TYPES tt_buckets TYPE STANDARD TABLE OF ts_bucket WITH KEY upper_bound.
    
    DATA:
      mt_buckets TYPE tt_buckets,
      mv_sum     TYPE zif_otel_metric=>tv_value,
      mv_count   TYPE i.

ENDCLASS.

CLASS zcl_otel_histogram IMPLEMENTATION.

  METHOD zif_otel_histogram~record.
    mv_sum = mv_sum + value.
    mv_count = mv_count + 1.
    
    LOOP AT mt_buckets ASSIGNING FIELD-SYMBOL(<bucket>).
      IF value <= <bucket>-upper_bound.
        <bucket>-count = <bucket>-count + 1.
        EXIT.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
