*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

interface lif_stack.
  methods push importing data type ref to data.
  methods pop returning value(data) type ref to data.
  methods last returning value(data) type ref to data.
endinterface.

class lcl_stack definition.
  public section.
    interfaces lif_stack.
  private section.
    data _stack type table of ref to data.
endclass.

class lcl_stack implementation.

  method lif_stack~push.
    insert data into _stack index 1.
  endmethod.

  method lif_stack~pop.
    data = me->lif_stack~last( ).
    check data is bound.
    delete _stack index 1.
  endmethod.

  method lif_stack~last.
    check _stack is not initial.
    data = _stack[ 1 ].
  endmethod.

endclass.

class lcl_span_stack_processor definition.
  public section.
    methods constructor.
    methods current_context returning value(result) type ref to zif_otel_span_context.
    interfaces zif_otel_trace_processor.
  private section.
    data stack type ref to lif_stack.
endclass.

class lcl_span_stack_processor implementation.

  method zif_otel_trace_processor~on_span_start.
    me->stack->push( ref #( span ) ).
  endmethod.

  method zif_otel_trace_processor~on_span_event.
  endmethod.

  method zif_otel_trace_processor~on_span_end.
    me->stack->pop( ).
  endmethod.

  method constructor.
    super->constructor( ).
    me->stack = new lcl_stack(  ).
  endmethod.

  method current_context.
    types span_type type ref to zif_otel_span.
    data(span) = cast span_type( me->stack->last( ) ).
    check span is bound.
    result = cast #( span->* ).
  endmethod.

endclass.
