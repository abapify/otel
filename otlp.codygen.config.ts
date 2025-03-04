import { config, from } from 'codygen';

export default config({
    prompt: from('prompts').read(['otlp.md', 'abap.md']),
    context: [
        'git_modules/open-telemetry/opentelemetry-proto/opentelemetry/proto/common/v1/common.proto',
        'git_modules/open-telemetry/opentelemetry-proto/opentelemetry/proto/resource/v1/resource.proto',
        'git_modules/open-telemetry/opentelemetry-proto/opentelemetry/proto/trace/v1/trace.proto',
        'git_modules/open-telemetry/opentelemetry-proto/opentelemetry/proto/metrics/v1/metrics.proto',
        'git_modules/open-telemetry/opentelemetry-proto/opentelemetry/proto/logs/v1/logs.proto'
    ]
    ,
    output: 'src/otlp',
});