vec2 rotate(vec2 uv, float fi) {
    return vec2(uv.x * cos(fi) - uv.y * sin(fi),
                uv.y * cos(fi) + uv.x * sin(fi));
}

float ping_pong(float t, float r) {
    t = mod(t, r * 2.);
    if (t > r) {
        return 2. * r - t;
    }
    
    return t;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv0 = fragCoord/iResolution.xy;
    
    uv0 -= 0.5;
    uv0 *= 2.;
    uv0.x *= iResolution.x/iResolution.y;
    vec2 uv;
    uv = uv0;

    
    float startAngle = iTime;
    uv = rotate(uv, startAngle);
    
    int steps = 17;
    float inc = radians(180.) / float(steps);
    float mask = 0.;
    vec3 col;
    
    for (int i = 0; i < steps; i++) {
        float fi = atan((uv.x * uv.x * ping_pong(iTime, 0.5))  / uv.y / uv.y);
        float r = fi;
        mask += 1. - step(0.01, abs(r - length(uv * 2.)));
        uv = rotate(uv, inc);
        col = mix(0.5 + 0.5*cos(iTime+uv.xyx+vec3(0,2,4)), vec3(0.5, 0.3, 0.4), fi);
    }
    // Output to screen
    fragColor = vec4(mask * col,1.0);
}