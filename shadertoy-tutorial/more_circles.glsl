float circle(vec2 uv, vec2 center, float r, float blur) {
    float d = length(uv - center);
    float c = smoothstep(r, r - blur, d);
    return c;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
    vec2 uv = fragCoord.xy / iResolution.xy;
    
    uv -= 0.5;
    uv.x *= iResolution.x / iResolution.y;
    float mask = circle(uv, vec2(0.), .35, .05);
    mask -= circle(uv, vec2(-.13, .1), .07, .01);
    mask -= circle(uv, vec2(.13, .1), .07, .01);
    
    float mouth = circle(uv, vec2(0.), 0.25, .01);
    mouth -= circle(uv, vec2(0., 0.1), 0.25, .01);
    mask -= mouth;

    fragColor = vec4(vec3(mask), 1.0);
}