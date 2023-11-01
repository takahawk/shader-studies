float pingpong_remainder(float a, float b) {
    float c = fract(a / (2. * b));
    if (c > 0.5)
        return (1. - (c - 0.5) * 2.) * b;
    return c * 2. * b;
}

vec2 movingPosition(vec2 p, vec2 lbound, vec2 ubound, float t, float dx, float dy) {
    float x = lbound.x - p.x + dx * t;
    float y = lbound.y - p.y + dy * t;
    
    float w = ubound.x - lbound.x;
    float h = ubound.y - lbound.y;
    
    x = pingpong_remainder(x - lbound.x, w);
    y = pingpong_remainder(y - lbound.y, h);
    
    return vec2(lbound.x + x, lbound.y + y);
}

float circle(vec2 uv, vec2 c, float r) {
    return smoothstep(r, 0.0, length(uv - c));
}

float line(vec2 uv, vec2 p1, vec2 p2, float b) {
    
    float mask = smoothstep(b, 0., abs(length(normalize(p2 - uv) - normalize(p2 - p1))));
    return mask;
}

float rect(vec2 uv, vec2 lbound, vec2 ubound, float b) {
    float mask = line(uv, lbound, vec2(lbound.x, ubound.y), b);
    mask += line(uv, lbound, vec2(ubound.x, lbound.y), b);
    mask += line(uv, ubound, vec2(ubound.x, lbound.y), b);
    mask += line(uv, ubound, vec2(lbound.x, ubound.y), b);
    return mask;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = fragCoord/iResolution.xy;
    uv -= .5;
    uv.x *= iResolution.x / iResolution.y;

    // Time varying pixel color
    float r = 0.1;
    vec2 c = movingPosition(vec2(0., 0.), vec2(-.6, -.25), vec2(.6, .25), iTime, 0.3, 0.3);
    vec3 col = circle(uv, c, r) * vec3(1.0, 1., 1.);
    col += rect(uv, vec2(-.6, -.25) - r, vec2(.6, .25) + r, 0.01) * vec3(1., 1., 1.);

    // Output to screen
    fragColor = vec4(col,1.0);
}