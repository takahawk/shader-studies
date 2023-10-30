#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;

float plot(vec2 uv, float t) {
    return smoothstep(t - 0.02, t, uv.y) - smoothstep(t, t + 0.02, uv.y);
}

void main() {
    vec2 uv = gl_FragCoord.xy / u_resolution;
    float y = smoothstep(0.2, 0.8, uv.x);
    vec3 color = vec3(y);
    float pct = plot(uv, y);
    color = (1. - pct) * color + pct * vec3(0., 1., 0.);

    gl_FragColor = vec4(color, 1.);
}