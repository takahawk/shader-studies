#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;

vec3 blue = vec3(0., 0., 1.);
vec3 yellow = vec3(1., 1., 0.);

void main() {
    uv = gl_FragCoord.xy / u_resolution.xy;
    vec3 color = mix(yellow, blue, step(0.5, uv.y));
    gl_FragColor = vec4(color, 1.);
}