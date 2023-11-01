float circle(vec2 uv, vec2 center, float r, float blur) {
    float d = length(uv - center);
    float c = smoothstep(r, r - blur, d);
    return c;
}

float smiley(vec2 uv, vec2 center, float size) {
    uv -= center;
    uv /= size;

    float mask = circle(uv, vec2(0.), .35, .05);
    mask -= circle(uv, vec2(-.13, .1), .07, .01);
    mask -= circle(uv, vec2(.13, .1), .07, .01);
    
    float mouth = circle(uv, vec2(0.), 0.25, .01);
    mouth -= circle(uv, vec2(0., 0.1), 0.25, .01);
    mask -= mouth;

    return mask;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fragCoord.xy / iResolution.xy;

    uv -= 0.5;
    uv.x *= iResolution.x / iResolution.y;
    
    float mask = smiley(uv, vec2(0.0), 1.0);
    vec3 color = vec3(1.0, 1.0, 0.0);

    fragColor = vec4(mask * color, 1.0);
}