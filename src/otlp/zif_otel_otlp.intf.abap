interface zif_otel_otlp
  public .


  types:
    begin of schema.
      include type zif_otel_otlp_trace=>traces_data.
      include type zif_otel_otlp_logs=>logs_data.
      include type zif_otel_otlp_metrics=>metrics_data.
  types:
    end of schema.



endinterface.
