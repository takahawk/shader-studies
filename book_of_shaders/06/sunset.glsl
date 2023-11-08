#ifdef GL_ES
precision mediump float;
#endif

uniform float u_time;
uniform vec2 u_resolution;

vec3 indigo = vec3(0.396,0.384,0.561);
vec3 darkRed = vec3(0.733,0.18,0.063);
vec3 orange = vec3(0.98,0.733,0.361);
vec3 beige = vec3(0.969,0.894,0.729);
vec3 yellow = vec3(1., 1., 0.);

vec3 get_pct(float y) {
    return vec3(pow(y, 2.) / 0.25, y, y);
}

void main() {
    vec2 uv = gl_FragCoord.xy / u_resolution.xy;
    uv -= 0.5;
    uv *= 2.;
    uv.x *= u_resolution.x / u_resolution.y;

    vec3 color = vec3(0., 0.5, 0.);
    vec3 pct = vec3(pow(uv.y, 2.) / 0.25, uv.y, uv.y); // smoothstep(0., 1., uv.y));

    if (uv.y > 0.) {
        vec3 col = mix(yellow, darkRed, smoothstep(-1., 1., sin(u_time)));
        if (uv.y < 0.2)
        	color = mix(col, orange, get_pct(uv.y) / 0.2);
        else if (uv.y < 0.5)
        	color = mix(orange, indigo, get_pct(uv.y - 0.2) / 0.3);
        else
        	color = mix(indigo, beige, get_pct(uv.y - 0.5) / 0.5);
    }
    

    gl_FragColor = vec4(color, 1.0); 
}