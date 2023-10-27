#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

vec4 original() {
    vec2 st = gl_FragCoord.xy / u_resolution;
    return vec4(st.x, st.y, 0.0, 1.0);
}

vec4 with_mouse_position() {
    vec2 st = gl_FragCoord.xy / u_resolution;
    vec2 blue = gl_FragCoord.xy / u_mouse;
    return vec4(st.x, st.y, (blue.x + blue.y) * 0.5, 1.0);
}

void main() {
    gl_FragColor = original();
}