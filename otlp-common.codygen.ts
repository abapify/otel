import { config, from } from 'codygen';

export default config({
    prompt: from('prompts').read(['otlp/common.md', 'otlp.md', 'abap.md']),
    context: [
        'git_modules/open-telemetry/opentelemetry-proto/opentelemetry/proto/common/v1/common.proto',
        'git_modules/open-telemetry/opentelemetry-proto/opentelemetry/proto/resource/v1/resource.proto',
    ]
    ,
    output: 'src/otlp/common',
});