import { config, from } from 'codygen';

export default config({
    prompt: from('prompts').read(['otlp/trace.md', 'otlp.md', 'abap.md']),
    context: [
        'git_modules/open-telemetry/opentelemetry-proto/opentelemetry/proto/common/v1/common.proto',
        'git_modules/open-telemetry/opentelemetry-proto/opentelemetry/proto/resource/v1/resource.proto',
        'git_modules/open-telemetry/opentelemetry-proto/opentelemetry/proto/trace/v1/trace.proto',
        'src/otlp/common/zif_otel_otlp_common.intf.abap',
        'src/otlp/common/zcl_otel_otlp_resource.intf.abap'],
    output: 'src/otlp/trace',
});