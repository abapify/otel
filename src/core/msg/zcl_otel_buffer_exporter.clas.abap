class ZCL_OTEL_BUFFER_EXPORTER definition
  public
  create public .

public section.

  interfaces ZIF_OTEL_CX_PROXY .
  interfaces ZIF_OTEL_EXPORTER .

  aliases EXPORT
    for ZIF_OTEL_EXPORTER~EXPORT .

  types STREAM_TYPE type ref to ZIF_OTEL_STREAM .
  types buffer_type type ref to zif_otel_msg_buffer.

  methods CONSTRUCTOR
    importing
      buffer type buffer_type
      !stream type STREAM_TYPE
      !BATCH_SIZE type I optional .

protected section.
  private section.

    methods on_buffer_update for event updated of zif_otel_msg_buffer.

    data stream type stream_type.
    data batch_size type i.
    data _buffer type buffer_type.

    methods ready_to_publish
      returning
        value(result) type abap_bool.

ENDCLASS.



CLASS ZCL_OTEL_BUFFER_EXPORTER IMPLEMENTATION.


  method CONSTRUCTOR.

    super->constructor( ).

    me->stream = stream.
    me->batch_size = batch_size.
    me->_buffer = buffer.

    set handler on_buffer_update for buffer.

  endmethod.


  method ON_BUFFER_UPDATE.
    if ready_to_publish(  ).
      export(  ).
    endif.
  endmethod.


  method READY_TO_PUBLISH.
    check _buffer is bound.
    result = xsdbool( me->_buffer->size(  ) ge me->batch_size ).
  endmethod.


  method ZIF_OTEL_EXPORTER~EXPORT.

    check _buffer is bound.
    check _buffer->size( ) is not initial.
    try.
        stream->publish( _buffer ).
      catch cx_static_check into data(lo_cx).
        raise event zif_otel_cx_proxy~cx
      exporting
        cx     = lo_cx
      .
    endtry.
    _buffer->clear(  ).
  endmethod.
ENDCLASS.
