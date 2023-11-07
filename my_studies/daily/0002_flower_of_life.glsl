vec3 palette( in float t, in vec3 a, in vec3 b, in vec3 c, in vec3 d )
{
    return a + b*cos( 6.28318*(c*t+d) );
}

vec2 rotate(vec2 uv, float angle) {
    return vec2(uv.x * cos(angle) - uv.y * sin(angle),
                uv.y * cos(angle) + uv.x * sin(angle));
}

float circle(vec2 uv, vec2 p, float r, float blur) {
    return smoothstep(blur, 0., abs(length(uv - p) - r));
}

float flower(vec2 uv, int iterations, float r, float blur) {
    if (iterations <= 0)
        return 0.;
    vec2 p = vec2(0., 0.);
    float result = circle(uv, p, r, blur);
    for (int i = 1; i < iterations; i++) {
        p.y += r;
        float circles = 6. * float(i);
        float angle = radians(360. / circles);
        for (float j = 0.; j < circles; j++) {
            result += circle(uv, p, r, blur);
            p = rotate(p, angle);
        }
    }
    return result;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = fragCoord/iResolution.xy;
    uv -= 0.5;
    uv *= 2.;
    uv.x *= iResolution.x / iResolution.y;

    vec3 a = vec3(0.5, 0.5, 0.5);
    vec3 b = vec3(0.5, 0.5, 0.5);
    vec3 c = vec3(1.0, 0.7, 0.4);
    vec3 d = vec3(0.00, 0.15, 0.20);
    vec3 col = palette(0.5 + mod(iTime - length(uv) * 13., 10.) / 10. , a, b, c, d);
    // Time varying pixel color
    vec3 res = flower(uv, 3, 0.25, 0.02)*col;
    res += circle(uv, vec2(0., 0.), 0.8, 0.04)*col;
    // vec2 p = vec2(0., -0.25);
    // vec3 col = vec3(1.) * circle(uv, p, 0.25, 0.02);// * (1. - step(0.01, abs(uv.x - 0.25)))
    // p = rotate(p, radians(90.));
    // col += vec3(1.) * circle(uv, p, 0.25, 0.02); // (1. - step(0.01, abs(uv.x - 0.25)));
    // Output to screen
    fragColor = vec4(res,1.0);
}