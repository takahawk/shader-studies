#define PI 3.1415926538

float inv(vec2 uv, vec2 p) {
    uv -= p;
    uv *= 16.;
    float y = 1. / uv.x;
    if (y < 0.)
        return 0.;
    return smoothstep(0.05, 0.0, abs(uv.y - y));
}

float chakra(vec2 uv, vec2 p, float r, float t) {
    uv -= p;
    float mask = 1. - smoothstep(0.0, 0.01, abs(length(uv) - r));
    if (mask > 0.)
        mask = abs(sin(mask + t));
    vec2 uv0 = uv;
    for (float angle = 0.; angle < PI; angle += PI / 4.) {
        uv.x = uv0.x * cos(angle) - uv0.y * sin(angle);
        uv.y = uv0.y * cos(angle) + uv0.y * sin(angle);
        mask += inv(uv, vec2(-0.0625, -0.0625));
    }
    // mask += inv(uv, vec2(-0.0625, -0.0625));
    return mask;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = fragCoord/iResolution.xy;
    uv -= .5;
    uv.x *= iResolution.x/iResolution.y;

    // Time varying pixel color
    vec3 col = vec3(1., 0., 0.) * chakra(uv, vec2(0., -.2), 0.05, iTime);

    // Output to screen
    fragColor = vec4(col,1.0);
}