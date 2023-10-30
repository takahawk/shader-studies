#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.1415926535897932384626433832795

uniform vec2 u_resolution;
uniform float u_time;

float plot(vec2 uv, float t) {
    return smoothstep(t - 0.02, t, uv.y) - smoothstep(t, t + 0.02, uv.y);
}

void main() {
    vec2 uv = gl_FragCoord.xy/u_resolution;
    uv -= 0.5;
    uv *= 2.;
    float y = sin(uv.x * PI + u_time);
    vec3 color = vec3(y);
    float pct = plot(uv, y);

    color = (1. - pct) * color + pct * vec3(0., 1., 0.);
    gl_FragColor = vec4(color, 1.0);
}