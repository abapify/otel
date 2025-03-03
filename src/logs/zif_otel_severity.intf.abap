"! OpenTelemetry Severity Levels
"! Defines severity levels according to OpenTelemetry specifications.
INTERFACE zif_otel_severity PUBLIC.

  "! Type definition for severity levels.
  TYPES severity_type TYPE i.

  " Severity level constants for OpenTelemetry logging.
  CONSTANTS: BEGIN OF severity,
               unassigned TYPE severity_type VALUE 0,
               trace      TYPE severity_type VALUE 1,
               trace2     TYPE severity_type VALUE 2,
               trace3     TYPE severity_type VALUE 3,
               trace4     TYPE severity_type VALUE 4,
               debug      TYPE severity_type VALUE 5,
               debug2     TYPE severity_type VALUE 6,
               debug3     TYPE severity_type VALUE 7,
               debug4     TYPE severity_type VALUE 8,
               info       TYPE severity_type VALUE 9,
               info2      TYPE severity_type VALUE 10,
               info3      TYPE severity_type VALUE 11,
               info4      TYPE severity_type VALUE 12,
               warn       TYPE severity_type VALUE 13,
               warn2      TYPE severity_type VALUE 14,
               warn3      TYPE severity_type VALUE 15,
               warn4      TYPE severity_type VALUE 16,
               error      TYPE severity_type VALUE 17,
               error2     TYPE severity_type VALUE 18,
               error3     TYPE severity_type VALUE 19,
               error4     TYPE severity_type VALUE 20,
               fatal      TYPE severity_type VALUE 21,
               fatal2     TYPE severity_type VALUE 22,
               fatal3     TYPE severity_type VALUE 23,
               fatal4     TYPE severity_type VALUE 24,
             END OF severity.

ENDINTERFACE.
