interface zif_otel_metric_types
  public .

  types metric_type_type type string .

  constants:
      counter         type metric_type_type value 'counter',
      histogram       type metric_type_type value 'histogram',
      gauge           type metric_type_type value 'gauge',
      up_down_counter type metric_type_type value 'up-down-counter'.

endinterface.
