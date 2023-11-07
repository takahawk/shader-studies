#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359

uniform float u_time;
uniform vec2 u_resolution;

float plot(vec2 uv, float pct) {
    return smoothstep(pct - 0.01, pct, uv.y) -
           smoothstep(pct, pct + 0.01, uv.y);
}

void main() {
    vec2 uv = gl_FragCoord.xy / u_resolution.xy;
}