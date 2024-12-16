class zcl_abap2otel_msg definition
  public
  inheriting from zcl_otel_msg_json
  create public.


  public section.

    interfaces zif_otel_msg_buffer.


    types message_type type zif_abap2otel=>message_ts .

    methods constructor .

    types:
      span_ts   type line of message_type-spans,
      log_ts    type line of message_type-logs,
      metric_ts type line of message_type-metrics.

    methods add_span   importing span type span_ts.
    methods add_log    importing log type log_ts.
    methods add_metric importing metric type metric_ts.

  protected section.

    methods get_data
        redefinition .
    methods get_source
        redefinition .
  private section.
    data message type ref to  message_type.
    aliases updated for zif_otel_msg_buffer~updated.


endclass.



class zcl_abap2otel_msg implementation.

  method constructor.
    super->constructor( ).
    me->message = new #( ).
  endmethod.


  method get_data.
    result = message.
  endmethod.


  method get_source.

    " otherwise we need to introduce a static format with data as root
    " currently it is not supported by our ABAP2Otel spec

    result = value #(
     ( name = 'SPANS'  value = ref #( me->message->spans ) )
     ( name = 'LOGS'   value = ref #( me->message->logs ) )
     ( name = 'METRICS' value = ref #( me->message->metrics ) )
    ).

  endmethod.

  method add_log.

    append log to me->message->logs.
    raise event updated.

  endmethod.

  method add_metric.

    append metric to me->message->metrics.
    raise event updated.

  endmethod.

  method add_span.

    append span to me->message->spans.
    raise event updated.

  endmethod.

  method zif_otel_msg_buffer~clear.

    clear me->message->*.

  endmethod.

  method zif_otel_msg_buffer~size.

    " very simple logic - we assume 1 record in one of those tables = 1 message
    result = lines( me->message->spans ) + lines(  me->message->logs ) + lines(  me->message->metrics ).

  endmethod.

endclass.
