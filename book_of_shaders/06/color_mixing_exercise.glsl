#ifdef GL_ES
precision mediump float;
#endif

uniform float u_time;

vec3 red = vec3(1., 0., 0.);
vec3 black = vec3(0., 0., 0.);

void main() {
    float time = mod(u_time, 10.);
    vec3 col = mix(black, red, smoothstep(0.5 * (time / 2.), 0., fract(time / 1.5)));

    gl_FragColor = vec4(col, 1.);
}