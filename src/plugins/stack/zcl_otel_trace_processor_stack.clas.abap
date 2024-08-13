class zcl_otel_trace_processor_stack definition
  public
  final
  create public .

  public section.
    interfaces zif_otel_trace_processor.
  protected section.
  private section.
ENDCLASS.



CLASS ZCL_OTEL_TRACE_PROCESSOR_STACK IMPLEMENTATION.


  method zif_otel_trace_processor~on_span_end.

  endmethod.


  method zif_otel_trace_processor~on_span_event.

  endmethod.


  method zif_otel_trace_processor~on_span_start.

    data(stack) = cl_abap_get_call_stack=>get_call_stack( ).

    try.
        data(stack_struct) = cl_abap_get_call_stack=>format_call_stack_with_struct( stack = value #( ( stack[ stack_depth + 1 ] ) )  ).
        data(source_stack) = stack_struct[ 1 ].

        span->attributes( )->append( entries = value #(
          ( name = 'sap.stack.progname' value = source_stack-progname  )
          ( name = |sap.stack.{ to_lower( source_stack-kind ) }| value = source_stack-event_long  )
          ( name = 'sap.stack.line' value = source_stack-line   )
        ) ).

      catch cx_sy_itab_line_not_found.
    endtry.

  endmethod.
ENDCLASS.
