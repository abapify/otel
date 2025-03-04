# Generate OTLP interfaces in ABAP

This is machine generated promt and it will be parsed by machine.

- do not use intro
- do not give summary
- even similar steps should be done for other files - please provide each - do not skip anything!
- please generate all of the requested interfaces - do not skip anything!
- do not stop - generate everything with one response fully. don't break files in the middle
- each code snippet should come with a file name like ```json:tsconfig.json
- do not imagine any file paths - all files should be be in a root (just filename)
- please think before responding - don't hallutinate

## Common

- resource is zif_otel_otlp_resource=>resource

## Enums

For enums like SeverityNumber we need to create an enum type like this:

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
severity_number_type type i.
constants:
begin of Severity_Number,
TRACE type severity_number_type value 1,
TRACE2 type severity_number_type value 2,
...
end of Severity_Number.
```

notice that we are removing severity* prefix because all fields of enum start with severity*

## Type mapping

- Our target ABAP structure will be serialiized as JSON ( asJSON )
- therefore we need to follow rules mentioned here https://protobuf.dev/programming-guides/json/
- on top of that since our target is asJSON - we need to use some specific types for some fields
- bool is xsdboolean
- timestamp is XSDDATETIME_Z
- binary becomes string too, not xstring
- int64 is string

## Naming conventions

- For example if file name is `example.proto` then interface should be zif_otel_otlp_example.intf.abap
- please generate types using snakeCase to snake_case conversion
- types in the interface should be named as they are named in a proto schema. Only case conversion is required

## Reference resolution

- please resolve properly all references in proto against newly generated interfaces
- please analyze that you resolve all references in the proto schema properly
