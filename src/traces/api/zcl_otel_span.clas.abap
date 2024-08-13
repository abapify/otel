class zcl_otel_span definition
  public
  final
  create private

  global friends zcl_otel_tracer .

  public section.

    interfaces zif_otel_has_attributes .
    interfaces zif_otel_context .
    interfaces zif_otel_span .
    interfaces zif_otel_span_context .

    methods constructor
      importing
        !name             type csequence
        value(start_time) type timestampl optional
        !context          type ref to zif_otel_context optional .
    methods get_serializable
      returning
        value(result) type ref to zif_otel_span_serializable .
  protected section.
  private section.

    aliases name for zif_otel_span~name.
    aliases trace_id for zif_otel_span~trace_id.
    aliases span_id for zif_otel_span~span_id.
    aliases parent_span_id for zif_otel_span~parent_span_id.
    aliases start_time for zif_otel_span~start_time.
    aliases end_time for zif_otel_span~end_time.
    aliases events for zif_otel_span~events.
    aliases links for zif_otel_span~links.
    aliases status for zif_otel_span~status.

    events span_end exporting value(stack_depth) type i.
    events span_event exporting value(event) type ref to zif_otel_span_event value(stack_depth) type i.
    data attributes type ref to zcl_otel_attribute_map.

endclass.



class zcl_otel_span implementation.


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


  method get_serializable.

    data(serializable) = new lcl_serializable_span(  ).
    data(span) = cast zif_otel_span( me ).

    serializable->zif_otel_span_serializable~span_data = value #(
      name           = span->name
      span_id        = to_lower( conv string( span->span_id ) )
      trace_id       = to_lower( conv string( span->trace_id ) )
      parent_span_id = to_lower( conv string( span->parent_span_id ) )
      start_time     = span->start_time
      end_time       = span->end_time
      attrs          = span->attributes(  )->entries(  )
      events         = value #(
        for event in span->events
        ( name      = event->name
          attrs = event->attributes(  )->entries(  )
          timestamp = event->timestamp
        )
        )
*      status         = span->status
      links          = value #(
        for link in span->links
        ( span_id   = link->context->span_id
          trace_id  = link->context->trace_id
       )
       )
    ).

    result = serializable.

  endmethod.


  method zif_otel_has_attributes~attributes.
    result = me->attributes.
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
  method zif_otel_span_context~get_context.
    result = value #(
    trace_id = me->trace_id
    span_id = me->span_id
    ).


  endmethod.

endclass.
