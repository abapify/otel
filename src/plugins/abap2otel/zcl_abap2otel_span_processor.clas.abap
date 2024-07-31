class zcl_abap2otel_span_processor definition
inheriting from zcl_otel_trace_processor
  public

  create public .

  public section.
    methods constructor
      importing
        exporter   type ref to zif_otel_msg_bus
        batch_size type i optional.
    .
    "interfaces
    methods zif_otel_trace_processor~on_span_end redefinition.
    methods flush.
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

class zcl_abap2otel_span_processor implementation.

  method get_buffer.
    if me->buffer is not bound.
      me->buffer = new #( ).
    endif.
    result = me->buffer.
  endmethod.


  method constructor.

    super->constructor( ).
    me->message_bus = exporter.
    me->batch_size = batch_size.

  endmethod.


  method zif_otel_trace_processor~on_span_end.
    check message_bus is bound.
    " introducing buffer for spans
    data(buffer) = get_buffer( ).

    buffer->add_span( value #(
      name           = span->name
      span_id        = span->span_id
      trace_id       = span->trace_id
      parent_span_id = span->parent_span_id
      start_time     = span->start_time
      end_time       = span->end_time
      "attrs          = span->attributes
      events         = value #( for event in span->events
                        ( name      = event->name
*         attrs = event->attributes
                          timestamp = event->timestamp
                        )
                        )
*      status         = span->status
      links          = value #( for link in span->links
                        ( span_id   = link->context->span_id
                          trace_id  = link->context->trace_id
                       )
                       )
     )  ).

    if ready_to_publish(  ).
      flush(  ).
    endif.
  endmethod.

  method ready_to_publish.

    result = xsdbool( me->get_buffer(  )->size(  ) ge me->batch_size ).

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

endclass.
