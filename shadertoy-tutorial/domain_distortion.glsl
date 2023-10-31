float band(float t, float start, float end, float blur) {
    float step1 = smoothstep(start - blur, start + blur, t);
    float step2 = smoothstep(end + blur, end - blur, t);
    return step1 * step2;
}

float rect(vec2 uv, vec2 start, vec2 size, float blur) {
    float band1 = band(uv.x, start.x, start.x + size.x, blur);
    float band2 = band(uv.y, start.y, start.y + size.y, blur);
    return band1 * band2;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fragCoord.xy / iResolution.xy;
    uv -= 0.5;
    uv.x *= iResolution.x / iResolution.y;

    float mask = rect(uv, vec2(-0.2, -0.3), vec2(0.4, 0.6), 0.01);
    
    fragColor = vec4(vec3(mask), 1.);
}