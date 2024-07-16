CLASS zcl_otel_span DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE GLOBAL FRIENDS zcl_otel_tracer.

  PUBLIC SECTION.

  INTERFACES zif_otel_span.

   methods constructor
      importing
        !name             type csequence
        value(start_time) type timestampl optional
        context TYPE REF TO zif_otel_context OPTIONAL.

  PROTECTED SECTION.
  PRIVATE SECTION.

  ALIASES name for zif_otel_span~name.
  ALIASES trace_id for zif_otel_span~trace_id.
  ALIASES span_id for zif_otel_span~span_id.
  ALIASES parent_span_id for zif_otel_span~parent_span_id.
  ALIASES start_time for zif_otel_span~start_time.
  ALIASES end_time for zif_otel_span~end_time.

  EVENTS span_end.
  EVENTS span_event.

ENDCLASS.

CLASS zcl_otel_span IMPLEMENTATION.
  METHOD constructor.

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
        CATCH cx_sy_move_cast_error.
        ENDTRY.
        endif.

        " trace id should be always generated ( if not inherited )
        if me->trace_id is INITIAL.
            TRY.
                me->trace_id = cl_system_uuid=>create_uuid_x16_static( ).
              CATCH cx_uuid_error.
                "handle exception
            ENDTRY.
        ENDIF.

        " span Id always unique
        " there is no out of the box function to generate 8-byte uuid
        me->span_id = lcl_randomizer=>generate_hex( 16 ).

        me->name = name.


  ENDMETHOD.

  METHOD zif_otel_span~end.

    check me->end_time is initial.

    if end_time is initial.
      get time stamp field end_time.
    endif.

    me->end_time = end_time.

    raise event span_end.

  ENDMETHOD.

ENDCLASS.
