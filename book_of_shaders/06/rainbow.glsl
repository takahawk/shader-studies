#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;

vec3 red = vec3(1., 0., 0.);
vec3 green = vec3(0., 1., 0.);
vec3 blue = vec3(0., 0., 1.);
vec3 yellow = mix(red, green, 0.5);
vec3 orange = mix(yellow, red, 0.5);
vec3 violet = mix(red, blue, 0.5);
vec3 indigo = mix(blue, violet, 0.5);

float ring(vec2 uv, float r1, float r2) {
    return step(r1, length(uv)) * step(length(uv), r2);
}

void main() {
    vec2 uv = gl_FragCoord.xy / u_resolution.xy;
    uv -= 0.5;
    uv *= 2.;
    uv.x *= u_resolution.x / u_resolution.y;

    vec2 color = ring(uv, 0.5, 0.6) * violet;

    gl_FragColor = vec4(color, 0.);
}