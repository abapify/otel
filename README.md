# ABAP Open telemetry

ABAP Telemetry minimalistic implementation

> [WIP] - work in progress! Some components may be changed

## Usage

```abap
" get tracer instance
data(trace) = zcl_otel_api=>traces( )->get_tracer( ).
" start span
data(span) = trace->start_span( 'Test trace' ).
" log span event
span->log( 'Span created' ).
" end span
span->end( ).
```

You can use span as a context for a child span
```abap
data(child_span)  = trace->start_span( name = 'Child span' context = span ).
```
By default this model is stateless - it's just raising ABAP events. To start handling these events our framework supports so called "plugins" or "middleware".
```abap
zcl_otel_trace=>api->use( your_handler_instance ).
zcl_otel_trace=>api->use( one_more_handler_instance ).
```
You can use as many handlers as you want. They will execute in the same order as they have been registered.

## Prerequesites

Following libraries have to be installed prior to this package
- [assert](https://github.com/abapify/assert) lib is used in unit tests
- [throw](https://github.com/abapify/throw) - throw an object as exception
- [fetch](https://github.com/abapify/fetch) - release-independent fetch polyfill
- [fetch-legacy](https://github.com/abapify/fetch-legacy) or [fetch-cloud](https://github.com/abapify/fetch-cloud) to have fetch working

We hope to find the solution to install dependencies automatically.

## Extensions

- [Telemetry via Logpoints](https://github.com/abapify/otel-logpoint) PoC solution using built-in log-points as the way to store trace data. Background job takes care of exporting via HTTP. Perfect use case for ECC where there are no daemons and MQTT
