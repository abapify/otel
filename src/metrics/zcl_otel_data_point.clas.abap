class zcl_otel_data_point definition
  public
  create private
  final
  global friends zcl_otel_metric.

  public section.
  interfaces zif_otel_data_point.
  interfaces zif_otel_has_uuid.
  interfaces ZIF_OTEL_HAS_ATTRIBUTES.

  methods constructor
    importing
      value type zif_otel_metric=>value_type
      context type ref to zif_otel_context optional
      attributes type zif_otel_metric=>attributes_type optional.

  protected section.
  private section.
    DATA _attributes TYPE REF TO zcl_otel_attribute_map.
    DATA context type ref to zif_otel_context.

endclass.



class zcl_otel_data_point implementation.

  method constructor.

    me->zif_otel_data_point~value = value.
    me->context = context.
    me->_attributes = new zcl_otel_attribute_map( ).
    me->_attributes->zif_otel_attribute_map~append( entries = attributes ).

    " it's needed for uniqueness of datapoint ( used in export )
    try.
        me->zif_otel_has_uuid~uuid = cl_system_uuid=>create_uuid_c22_static( ).
      catch cx_uuid_error.
        "handle exception
    endtry.

  endmethod.

  method zif_otel_has_attributes~attributes.
  result = me->_attributes.
  endmethod.

endclass.
