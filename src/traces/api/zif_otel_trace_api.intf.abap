interface zif_otel_trace_api
  public .

  interfaces zif_otel_exporter.

  " get tracer
  methods get_tracer
    importing new           type abap_bool optional
    returning value(result) type ref to zif_otel_tracer.

  " use processor
  methods use importing processor type ref to zif_otel_trace_processor.

  " some plugin processors might implement a batch queue mechanism
  " it means that they collect traces and other messages in the cache
  " since we do not have some standard signal like destructor in abap
  " we need somehow to provide a signlan to submit those changes
  " it could be that we find a better place for this function
  aliases export for zif_otel_exporter~export.


endinterface.
