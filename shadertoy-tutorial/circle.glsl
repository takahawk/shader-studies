void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fragCoord.xy / iResolution.xy;

    uv -= 0.5;
    uv.x *= iResolution.x / iResolution.y;
    float r = 0.3;
    float d = length(uv);

    float c = smoothstep(r, r - 0.03, d);
    fragColor = vec4(vec3(c), 0.0);
}