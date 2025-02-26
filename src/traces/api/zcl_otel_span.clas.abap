class ZCL_OTEL_SPAN definition
  public
  final
  create private

  global friends ZCL_OTEL_TRACER .

public section.

  interfaces ZIF_OTEL_HAS_ATTRIBUTES .
  interfaces ZIF_OTEL_CONTEXT .
  interfaces ZIF_OTEL_SPAN .
  interfaces ZIF_OTEL_SPAN_CONTEXT .

  methods CONSTRUCTOR
    importing
      !NAME type CSEQUENCE
      value(START_TIME) type TIMESTAMPL optional
      !CONTEXT type ref to ZIF_OTEL_CONTEXT optional .
  protected section.
private section.

  aliases END_TIME
    for ZIF_OTEL_SPAN~END_TIME .
  aliases EVENTS
    for ZIF_OTEL_SPAN~EVENTS .
  aliases LINKS
    for ZIF_OTEL_SPAN~LINKS .
  aliases NAME
    for ZIF_OTEL_SPAN~NAME .
  aliases PARENT_SPAN_ID
    for ZIF_OTEL_SPAN~PARENT_SPAN_ID .
  aliases SPAN_ID
    for ZIF_OTEL_SPAN~SPAN_ID .
  aliases START_TIME
    for ZIF_OTEL_SPAN~START_TIME .
  aliases STATUS
    for ZIF_OTEL_SPAN~STATUS .
  aliases TRACE_ID
    for ZIF_OTEL_SPAN~TRACE_ID .

  data ATTRIBUTES type ref to ZCL_OTEL_ATTRIBUTE_MAP .

  events SPAN_END
    exporting
      value(STACK_DEPTH) type I .
  events SPAN_EVENT
    exporting
      value(EVENT) type ref to ZIF_OTEL_SPAN_EVENT
      value(STACK_DEPTH) type I .

ENDCLASS.



CLASS ZCL_OTEL_SPAN IMPLEMENTATION.


  method constructor.

    " span start time
    " the earlier we count time - the better
    if start_time is initial.
      get time stamp field start_time.
    endif.
    me->start_time = start_time.

    " inherit context from the parent span
    if context is bound.
      try.
          data(span_context) = cast zif_otel_span_context( context ).
          me->trace_id = span_context->trace_id.
          me->parent_span_id = span_context->span_id.
        catch cx_sy_move_cast_error.
      endtry.
    endif.

    " trace id should be always generated ( if not inherited )
    if me->trace_id is initial.
      try.
          me->trace_id = cl_system_uuid=>create_uuid_x16_static( ).
        catch cx_uuid_error.
          "handle exception
      endtry.
    endif.

    " span Id always unique
    " there is no out of the box function to generate 8-byte uuid
    me->span_id = lcl_randomizer=>generate_hex( 8 ).

    me->name = name.

    me->attributes = new zcl_otel_attribute_map( ).

  endmethod.

  method zif_otel_has_attributes~attributes.
    result = me->attributes.
  endmethod.

  method zif_otel_span_context~get_context.
    result = value #(
    trace_id = me->trace_id
    span_id = me->span_id
    ).


  endmethod.


  method zif_otel_span~end.

    check me->end_time is initial.

    me->status = status.

    if end_time is initial.
      get time stamp field end_time.
    endif.

    me->end_time = end_time.

    raise event span_end exporting stack_depth = stack_depth + 1.

  endmethod.


  method zif_otel_span~fail.

    if reason is not initial.
      me->zif_otel_span~log( name = reason ).
    endif.

    me->zif_otel_span~end(
        status = me->zif_otel_span~span_status-error
    ).

  endmethod.


  method zif_otel_span~link.
    data(link) = new lcl_span_link( ).
    link->context = context.
    append link to me->links.
  endmethod.


  method zif_otel_span~log.

    data(event) = new lcl_span_event( ).
    event->name = name.
    event->span = me.

    append event to me->events.

    raise event span_event exporting event = event stack_depth = stack_depth + 1..

  endmethod.
  METHOD ZIF_OTEL_CONTEXT~DELETE_VALUE.

  ENDMETHOD.

  METHOD ZIF_OTEL_CONTEXT~GET_ENTRIES.

  ENDMETHOD.

  METHOD ZIF_OTEL_CONTEXT~GET_VALUE.

  ENDMETHOD.

  METHOD ZIF_OTEL_CONTEXT~SET_VALUE.

  ENDMETHOD.

ENDCLASS.
