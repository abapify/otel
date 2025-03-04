INTERFACE zif_otel_otlp_resource PUBLIC.

  TYPES:
    BEGIN OF resource,
      attributes              TYPE zif_otel_otlp_common=>key_values,
      dropped_attributes_count TYPE i,
    END OF resource.

ENDINTERFACE.
