#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;

float plot(vec2 uv) {
    return smoothstep(0.02, 0., abs(uv.x - uv.y));
}

void main() {
    vec2 uv = gl_FragCoord.xy / u_resolution;
    vec3 color = vec3(uv.x);
    float pct = plot(uv);
    color = (1. - pct) * color + pct * vec3(0.0, 1.0, 0.0);
    gl_FragColor = vec4(color, 1.0);
}