#ifdef GL_ES
precision mediump float
#endif

uniform vec2 u_resolution;
uniform float u_time;

uniform sampler2D u_tex0;
uniform vec2 u_tex0Resolution;


bool isNormalized(vec2 uv) {
    return uv.x <= 0.99 && uv.x > 0.01 && uv.y <= 0.99 && uv.y > 0.01;
}

float blink(float t, float period) {
    return step(0.5, fract(t / period));
}

vec4 projection(vec2 uv, vec2 diff, sampler2D tex) {
    if (!isNormalized(uv - diff))
        return vec4(0.);
    return texture2D(tex, uv - diff);
}

float skip_vertical(vec2 uv, float interval) {
    return step(0.5, fract(uv.y / interval));
}

void main() {
    vec2 uv = gl_FragCoord.xy / u_resolution.xy;

    float blinkPeriod = 0.2 / (u_time);
    vec2 offset = vec2(0.1, -0.1); // mix(vec2(0.2, -0.2), vec2(0.1, -0.1), u_time / 2.);
    vec4 color = projection(uv, vec2(0.), u_tex0) ;

    if (u_time < 2.) {
        color *= blink(u_time, blinkPeriod);
        color += skip_vertical(uv, 0.1) * 
                 projection(uv, offset, u_tex0) * 
                 blink(u_time + blinkPeriod / 2., blinkPeriod);
    }
    gl_FragColor = color;
}