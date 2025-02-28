class zcl_abap2otel_msg definition
  public
  inheriting from zcl_otel_msg_json
  create public .

  public section.

    interfaces zif_otel_msg_buffer .
    interfaces zif_otel_stream .

    types message_type type zif_abap2otel=>message_ts .
    types:
      span_ts   type line of message_type-spans .
    types:
      log_ts    type line of message_type-logs .
    types:
      metric_ts type line of message_type-metrics .

    methods constructor .
    methods add_span
      importing
        !span type span_ts .
    methods add_log
      importing
        !log type log_ts .
    methods add_metric
      importing
        !metric type metric_ts .
  protected section.

    methods get_data
        redefinition .
    methods get_source
        redefinition .
  private section.
    data message type ref to  message_type.
    aliases updated for zif_otel_msg_buffer~updated.


ENDCLASS.



CLASS ZCL_ABAP2OTEL_MSG IMPLEMENTATION.


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


  method zif_otel_msg_buffer~clear.

    clear me->message->*.

  endmethod.


  method zif_otel_msg_buffer~size.

    " very simple logic - we assume 1 record in one of those tables = 1 message
    result = lines( me->message->spans ) + lines(  me->message->logs ) + lines(  me->message->metrics ).

  endmethod.


  method zif_otel_stream~publish.
    " this method is implemented for the following scenario
    " sometimes we may parse logpoints and we want to stream them to HTTP
    " it's too expensive to send each logpoint in a different request that's why we want to batch
    " so with the help of this method we can stream from RTM processor logpoint data and buffer them in this instance in a parsed way
    " then later we can stream aggregated data to HTTP
    check message is bound.

    try.

        data(abap2otel) = cast zcl_abap2otel_msg( message ).
        data(new_message) = abap2otel->message.

        append lines of new_message->logs to me->message->logs.
        append lines of new_message->spans to me->message->spans.
        append lines of new_message->metrics to me->message->metrics.

      catch cx_sy_move_cast_error.
    endtry.

    raise event updated.
  endmethod.
ENDCLASS.
