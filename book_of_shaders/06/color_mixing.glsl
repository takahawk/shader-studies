#ifdef GL_ES
precision mediump float;
#endif

uniform float u_time;
vec3 colorA = vec3(1., 0., 0.);
vec3 colorB = vec3(0.,1.,0.);


void main() {
    float pct = sin(u_time);
    vec3 col = mix(colorA, colorB, pct);
    gl_FragColor = vec4(col, 1.);
}