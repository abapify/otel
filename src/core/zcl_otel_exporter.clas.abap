class zcl_otel_exporter definition abstract

  public

  create public .

  public section.

    interfaces zif_otel_cx_proxy.
    interfaces zif_otel_exporter.

    aliases export for zif_otel_exporter~export.

    methods constructor
      importing
        message_bus type ref to zif_otel_msg_bus
        batch_size  type i optional.

  protected section.

    methods get_buffer abstract returning value(result) type ref to zif_otel_msg_buffer.

  private section.

    methods buffer returning value(result) type ref to zif_otel_msg_buffer.


    methods on_buffer_update for event updated of zif_otel_msg_buffer.

    data message_bus type ref to zif_otel_msg_bus .
    data batch_size type i.
    data _buffer type ref to zif_otel_msg_buffer.

    methods ready_to_publish
      returning
        value(result) type abap_bool.



endclass.

class zcl_otel_exporter implementation.

  method constructor.

    me->message_bus = message_bus.
    me->batch_size = batch_size.

  endmethod.

  method zif_otel_exporter~export.

    data(buffer) = me->buffer(  ).

    check buffer is bound.
    check buffer->size( ) is not initial.
    try.
        message_bus->publish( buffer ).
      catch cx_static_check into data(lo_cx).
        raise event zif_otel_cx_proxy~cx
      exporting
        cx     = lo_cx
      .
    endtry.
    buffer->clear(  ).
  endmethod.

  method ready_to_publish.
    result = xsdbool( me->buffer( )->size(  ) ge me->batch_size ).
  endmethod.

  method on_buffer_update.
    if ready_to_publish(  ).
      export(  ).
    endif.
  endmethod.

  method buffer.

    if me->_buffer is not bound.
      me->_buffer = get_buffer(  ).
    endif.

    result = me->_buffer.

  endmethod.

endclass.
