INTERFACE zif_otel_otlp_metrics PUBLIC.

  TYPES:
    aggregation_temporality_type TYPE i,
    BEGIN OF aggregation_temporality,
      unspecified TYPE aggregation_temporality_type VALUE 0,
      delta       TYPE aggregation_temporality_type VALUE 1,
      cumulative  TYPE aggregation_temporality_type VALUE 2,
    END OF aggregation_temporality.

  TYPES:
    BEGIN OF exemplar,
      filtered_attributes      TYPE zif_otel_otlp_common=>key_values,
      time_unix_nano          TYPE int8,
      as_double               TYPE f,
      as_int                  TYPE int8,
      span_id                TYPE xstring,
      trace_id               TYPE xstring,
    END OF exemplar.

  TYPES:
    exemplars TYPE STANDARD TABLE OF exemplar WITH EMPTY KEY.

  TYPES:
    BEGIN OF number_data_point,
      attributes              TYPE zif_otel_otlp_common=>key_values,
      start_time_unix_nano   TYPE int8,
      time_unix_nano         TYPE int8,
      as_double              TYPE f,
      as_int                 TYPE int8,
      exemplars              TYPE exemplars,
      flags                  TYPE i,
    END OF number_data_point.

  TYPES:
    number_data_points TYPE STANDARD TABLE OF number_data_point WITH EMPTY KEY.

  TYPES:
    BEGIN OF gauge,
      data_points TYPE number_data_points,
    END OF gauge.

  TYPES:
    BEGIN OF sum,
      data_points            TYPE number_data_points,
      aggregation_temporality TYPE aggregation_temporality_type,
      is_monotonic           TYPE abap_bool,
    END OF sum.

  TYPES:
    BEGIN OF histogram_data_point,
      attributes              TYPE zif_otel_otlp_common=>key_values,
      start_time_unix_nano   TYPE int8,
      time_unix_nano         TYPE int8,
      count                  TYPE int8,
      sum                    TYPE f,
      bucket_counts          TYPE STANDARD TABLE OF int8 WITH EMPTY KEY,
      explicit_bounds        TYPE STANDARD TABLE OF f WITH EMPTY KEY,
      exemplars              TYPE exemplars,
      flags                  TYPE i,
      min                    TYPE f,
      max                    TYPE f,
    END OF histogram_data_point.

  TYPES:
    histogram_data_points TYPE STANDARD TABLE OF histogram_data_point WITH EMPTY KEY.

  TYPES:
    BEGIN OF histogram,
      data_points            TYPE histogram_data_points,
      aggregation_temporality TYPE aggregation_temporality_type,
    END OF histogram.

  TYPES:
    BEGIN OF buckets,
      offset        TYPE i,
      bucket_counts TYPE STANDARD TABLE OF int8 WITH EMPTY KEY,
    END
