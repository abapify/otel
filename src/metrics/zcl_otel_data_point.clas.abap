class zcl_otel_data_point definition
  public
  final .

  public section.
  interfaces zif_otel_data_point.

  methods constructor
    importing
      value type zif_otel_metric=>value_type
      context type zif_otel_metric=>context_type
      attributes type zif_otel_metric=>attributes_type.

  protected section.
  private section.

endclass.



class zcl_otel_data_point implementation.

  method constructor.

    me->zif_otel_data_point~value = value.
    me->zif_otel_data_point~context = context.
    me->zif_otel_data_point~attributes = attributes.

  endmethod.

endclass.
