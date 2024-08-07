class zcl_abap2otel_span_processor definition
inheriting from zcl_otel_trace_processor
  public

  create public .

  public section.
    interfaces zif_otel_exporter.
    methods constructor
      importing
        exporter   type ref to zif_otel_msg_bus
        batch_size type i optional.
    .
    "interfaces
    methods zif_otel_trace_processor~on_span_end redefinition.
    aliases flush for zif_otel_exporter~export.
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
ENDCLASS.



CLASS ZCL_ABAP2OTEL_SPAN_PROCESSOR IMPLEMENTATION.


  method constructor.

    super->constructor( ).
    me->message_bus = exporter.
    me->batch_size = batch_size.

  endmethod.


  method flush.

    check me->buffer is bound.
    check me->buffer->size( ) is not initial.

    try.
        message_bus->publish( me->buffer ).
        clear me->buffer.
      catch cx_static_check into data(lo_cx).
        " we cannot raise an exception because processor is not supposed to stop handlings traces
        throw_cx( lo_cx ).
    endtry.
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


  method zif_otel_trace_processor~on_span_end.
    check message_bus is bound.
    " introducing buffer for spans
    data(buffer) = get_buffer( ).

    buffer->add_span( span ).

    if ready_to_publish(  ).
      flush(  ).
    endif.
  endmethod.
ENDCLASS.
