# Generate OTLP interfaces in ABAP

This is machine generated promt and it will be parsed by machine.

- do not use intro
- do not give summary
- even similar steps should be done for other files - please provide each - do not skip anything!
- please generate all of the requested interfaces - do not skip anything!
- do not stop - generate everything with one response
- each code snippet should come with a file name like ```json:tsconfig.json

## Context

We need to convert the given in the context proto scemas to ABAP interfaces.

Here is the list of interfaces that you should generate:

- ZIF_OTEL_OTLP_COMMON
- ZIF_OTEL_OTLP_RESOURCE
- ZIF_OTEL_OTLP_TRACE
- ZIF_OTEL_OTLP_LOGS
- ZIF_OTEL_OTLP_METRICS

## Severity

For severity enum

```
enum SeverityNumber {
  // UNSPECIFIED is the default SeverityNumber, it MUST NOT be used.
  SEVERITY_NUMBER_UNSPECIFIED = 0;
  SEVERITY_NUMBER_TRACE  = 1;
  SEVERITY_NUMBER_TRACE2 = 2;
  SEVERITY_NUMBER_TRACE3 = 3;
  ...
}
```

please use following pattern:

```
types:
constants: severity_number_type type i.
begin of Severity_Number,
TRACE type severity_number_type value 1,
TRACE2 type severity_number_type value 2,
...
end of Severity_Number.
```

## Naming conventions

- For example if file name is `example.proto` then interface should be zif_otel_otlp_example.intf.abap
- please generate types using snakeCase to snake_case conversion
- types in the interface should be named as they are named in a proto schema. Only case conversion is required

## Reference resolution

- please resolve properly all references in proto against newly generated interfaces
