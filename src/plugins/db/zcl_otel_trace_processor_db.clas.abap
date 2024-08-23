class ZCL_OTEL_TRACE_PROCESSOR_DB definition
  public
  final
  create public .

public section.

  interfaces ZIF_OTEL_TRACE_PROCESSOR .
  interfaces ZIF_OTEL_COMMITABLE .
  protected section.
private section.

  aliases COMMIT
    for ZIF_OTEL_COMMITABLE~COMMIT .

  constants CONNECTION type STRING value 'R/3*OTEL' ##NO_TEXT.
ENDCLASS.



CLASS ZCL_OTEL_TRACE_PROCESSOR_DB IMPLEMENTATION.


  method ZIF_OTEL_COMMITABLE~COMMIT.

    commit connection (connection).

  endmethod.


  METHOD ZIF_OTEL_TRACE_PROCESSOR~ON_SPAN_END.

    data wa type zotel_spans writer for columns data.

    wa = value #(
      trace_id = span->trace_id
      span_id  = span->span_id
      start_time = span->start_time
      end_time = span->end_time ).

    insert zotel_spans connection (connection) from @wa.

    wa-data->write( cast zif_otel_serializable( span )->serialize( ) ).
    wa-data->close( ).

  ENDMETHOD.


  METHOD ZIF_OTEL_TRACE_PROCESSOR~ON_SPAN_EVENT.

  ENDMETHOD.


  METHOD ZIF_OTEL_TRACE_PROCESSOR~ON_SPAN_START.

  ENDMETHOD.
ENDCLASS.
