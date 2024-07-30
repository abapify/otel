class zcl_abap2otel_span_processor definition
inheriting from zcl_otel_trace_processor
  public
  final
  create public .

  public section.
    methods constructor importing exporter type ref to zif_otel_msg_bus.
    "interfaces
    methods zif_otel_trace_processor~on_span_end redefinition.
  protected section.
  private section.
  data message_bus type ref to zif_otel_msg_bus.
endclass.



class zcl_abap2otel_span_processor implementation.
  method zif_otel_trace_processor~on_span_end.
    check message_bus is bound.
    data(lo_message) = new zcl_abap2otel_msg( ).
    lo_message->message = new #(
      spans = value #(
      (
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
      )
    )
    ).
    try.
        message_bus->publish( lo_message ).
      catch cx_static_check into data(lo_cx).
        throw_cx( lo_cx ).
        "handle exception
    endtry.
  endmethod.
  method constructor.

    super->constructor( ).
    me->message_bus = exporter.

  endmethod.

endclass.
