class zcl_otel_span definition
  public
  final
  create private global friends zcl_otel_tracer.

  public section.

    interfaces zif_otel_span.

    methods constructor
      importing
        !name             type csequence
        value(start_time) type timestampl optional
        context           type ref to zif_otel_context optional.

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

    events span_end.
    events span_event exporting value(event) type ref to zif_otel_span_event.

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
    me->span_id = lcl_randomizer=>generate_hex( 16 ).

    me->name = name.


  endmethod.

  method zif_otel_span~end.

    check me->end_time is initial.

    if end_time is initial.
      get time stamp field end_time.
    endif.

    me->end_time = end_time.

    raise event span_end.

  endmethod.

  method zif_otel_span~log.

    data(event) = new lcl_span_event( ).
    event->name = name.
    event->span = me.

    append event to me->events.

    raise event span_event exporting event = event.

  endmethod.

  method zif_otel_span~link.
    data(link) = new lcl_span_link( ).
    link->context = context.
    append link to me->links.
  endmethod.

endclass.
