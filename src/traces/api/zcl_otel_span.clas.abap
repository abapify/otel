class zcl_otel_span definition
  public
  final
  create private

  global friends zcl_otel_tracer .

  public section.

    interfaces zif_otel_has_attributes .
    interfaces zif_otel_span .
    interfaces zif_otel_span_context .

    methods constructor
      importing
        !name             type csequence
        !context          type ref to zif_otel_span_context optional
        options           type zif_otel_span_options=>span_options optional.
  protected section.
  private section.

    aliases end_time
      for zif_otel_span~end_time .
    aliases events
      for zif_otel_span~events .
    aliases links
      for zif_otel_span~links .
    aliases name
      for zif_otel_span~name .
    aliases parent_span_id
      for zif_otel_span~parent_span_id .
    aliases span_id
      for zif_otel_span~span_id .
    aliases start_time
      for zif_otel_span~start_time .
    aliases status
      for zif_otel_span~status .
    aliases trace_id
      for zif_otel_span~trace_id .

    data attributes type ref to zcl_otel_attribute_map .

    events span_end
      exporting
        value(stack_depth) type i .
    events span_event
      exporting
        value(event)       type ref to zif_otel_span_event
        value(stack_depth) type i .

endclass.



class zcl_otel_span implementation.


  method constructor.

    " span start time
    " the earlier we count time - the better
    me->start_time = options-start_time.
    if me->start_time is initial.
      get time stamp field me->start_time.
    endif.

    " inherit context from the parent span
    if context is bound.
      me->trace_id = context->trace_id.
      me->parent_span_id = context->span_id.
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

    me->attributes = new zcl_otel_attribute_map( options-attributes ).

    " kind
    me->zif_otel_span~kind = options-kind.

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

endclass.
