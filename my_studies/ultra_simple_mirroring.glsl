vec2 mirrorx(vec2 uv) {
    return vec2(uv.x, abs(uv.y));
}

vec2 mirrory(vec2 uv) {
    return vec2(abs(uv.x), uv.y);
}

vec2 rotate(vec2 uv, float angle) {
    return vec2(uv.x * cos(angle) - uv.y * sin(angle),
                uv.y * sin(angle) + uv.x * cos(angle));
}

vec2 translate(vec2 uv, vec2 p) {
    return uv - p;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = fragCoord/iResolution.xy;    
    vec3 rose = vec3(243. / 255., 58. / 255., 106. / 255.);
    uv -= 0.5;
    uv.x *= iResolution.x/iResolution.y;
    uv *= 2.;
    uv = rotate(uv, radians(45.));
    // uv = translate(uv, vec2(0.5, 0.5));
    uv = mirrorx(uv);
    uv = mirrory(uv);
    
    float t = sin(iTime);
    uv *= abs(-t);
    
    
    float blur = 0.02 / t;
    float r = 0.5;
    float p = 0.5;
    vec3 col = vec3(0.);
    int iter = 16;
    for (int i = 0; i < iter; i++) {
        float mask = smoothstep(blur, 0., abs(r - sqrt((uv.x - p) * (uv.x - p) + (uv.y - p) * (uv.y - p))));
        col += mask * rose * (0.5 + float(i) / (float(iter) / 2.));
        r /= 2.;
        uv = translate(uv, vec2(-r , -r));
    }
    // Output to screen
    fragColor = vec4(col,1.0);
}