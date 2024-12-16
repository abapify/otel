class zcl_abap2otel_exporter definition inheriting from zcl_otel_exporter

  public

  create public .

  public section.

  protected section.

    methods get_buffer redefinition.
    data buffer type ref to zcl_abap2otel_msg.

  private section.

endclass.

class zcl_abap2otel_exporter implementation.

  method get_buffer.

    if me->buffer is not bound.
      me->buffer = new #(  ).
    endif.

    result = me->buffer.
  endmethod.

endclass.
