float fillCircle(vec2 uv, float r) {
    return 1. - step(r, length(uv));
}

float fillEllipse(vec2 uv, float a, float b) {
    return 1.0 - step(1., (uv.x * uv.x) / (a * a) + (uv.y * uv.y) / (b * b));
}

float halfEllipse(vec2 uv, float a, float b, float thickness) {
    if (uv.y > 0.)
        return 0.;
    return 1.0 - step(thickness, abs(1. - (uv.x * uv.x) / (a * a) - (uv.y * uv.y) / (b * b)));
}

float line(vec2 uv, float thickness) {
    return (step(0., uv.x) - step(1., uv.x)) * (1. - step(thickness / 2., abs(uv.y)));
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = fragCoord/iResolution.xy;
    uv -= 0.5;
    uv.x *= iResolution.x / iResolution.y;
    float angle = mod(iTime, radians(360.));
    uv = vec2(uv.x * cos(angle) - uv.y * sin(angle),
              uv.y * cos(angle) + uv.x * sin(angle));

    // Time varying pixel color
    vec3 col;
    vec2 uv2 = uv;
    uv2.y -= 0.125;
    col += fillEllipse(vec2(uv2.x - 0.125, uv2.y), 0.05, 0.125) * vec3(0.25,0.25,1.);
    col += fillEllipse(vec2(uv2.x + 0.125, uv2.y), 0.05, 0.125) * vec3(0.25,0.25,1.);
    uv2 = uv;
    uv2.y += 0.0625;
    col += halfEllipse(uv2, 0.35, 0.25, 0.04) * vec3(0.25,0.25,1.);
    uv2.x -= 0.325;
    uv2 *= 1. / 0.05;
    col += line(uv2, 0.2)* vec3(0.25,0.25,1.);
    uv2 = uv;
    uv2.y += 0.0625;
    uv2.x += 0.375;
    uv2 *= 1. / 0.05;
    col += line(uv2, 0.2)* vec3(0.25,0.25,1.);

    if (col == vec3(0.)) {
        col = vec3(1., 1., 0.) * fillCircle(uv, 0.5);
    }
    // Output to screen
    fragColor = vec4(col,1.0);
}