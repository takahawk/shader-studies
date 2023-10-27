#ifdef GL_ES
precision mediump float;
#endif

uniform float u_time;

vec4 original() {
    return vec4(abs(sin(u_time)), 0., 0., 1.);
}

vec4 slow() {
    return vec4(abs(sin(u_time)) * 0.01, 0., 0., 1.)
}

void main() {
    gl_FragColor = slow();
}