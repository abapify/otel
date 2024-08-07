class zcl_abap2otel_span_exporter definition

  public

  create public .

  public section.

    interfaces zif_otel_span_collector.
    aliases add_span for zif_otel_span_collector~add_span.

    interfaces zif_otel_cx_proxy.
    interfaces zif_otel_exporter.

    aliases export for zif_otel_exporter~export.

    methods constructor
      importing
        message_bus type ref to zif_otel_msg_bus
        batch_size  type i optional.

  protected section.

  private section.

    data message_bus type ref to zif_otel_msg_bus .
    data batch_size type i.

    types buffer_type type ref to zcl_abap2otel_msg.
    methods get_buffer returning value(result) type buffer_type.
    methods ready_to_publish
      returning
        value(result) type abap_bool.
    data buffer type buffer_type.

endclass.

class zcl_abap2otel_span_exporter implementation.

  method constructor.

    super->constructor( ).
    me->message_bus = message_bus.
    me->batch_size = batch_size.

  endmethod.

  method zif_otel_exporter~export.
    check me->buffer is bound.
    check me->buffer->size( ) is not initial.
    try.
        message_bus->publish( me->buffer ).
      catch cx_static_check into data(lo_cx).
        raise event zif_otel_cx_proxy~cx
      exporting
        cx     = lo_cx
      .
    endtry.
    clear me->buffer.
  endmethod.

  method get_buffer.
    if me->buffer is not bound.
      me->buffer = new #( ).
    endif.
    result = me->buffer.
  endmethod.

  method ready_to_publish.
    result = xsdbool( me->get_buffer(  )->size(  ) ge me->batch_size ).
  endmethod.


  method zif_otel_span_collector~add_span.
    check message_bus is bound.
    " introducing buffer for spans
    data(buffer) = get_buffer( ).

    buffer->add_span( span ).

    if ready_to_publish(  ).
      export(  ).
    endif.
  endmethod.
endclass.
