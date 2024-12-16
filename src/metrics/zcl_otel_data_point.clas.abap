class zcl_otel_data_point definition
  public
  final .

  public section.
  interfaces zif_otel_data_point.
  interfaces zif_otel_has_uuid.

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

    " it's needed for uniqueness of datapoint ( used in export )
    try.
        me->zif_otel_has_uuid~uuid = cl_system_uuid=>create_uuid_c22_static( ).
      catch cx_uuid_error.
        "handle exception
    endtry.

  endmethod.

endclass.
