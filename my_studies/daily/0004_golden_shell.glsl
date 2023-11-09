#define PHI 1.61803398875

float ellipseQuarter(vec2 uv, float a, float b, float blur) {
    if (uv.x < 0. || uv.y < 0.)
        return 0.;
    
    return smoothstep(blur, 0., pow(uv.x, 2.) / a + pow(uv.y, 2.) / b - 1.);
}

vec2 rotate(vec2 uv, float angle) {
    return vec2(uv.x * cos(angle) - uv.y * sin(angle),
                uv.y * cos(angle) + uv.x * sin(angle));
}

float radiusAngle(vec2 uv) {
    return acos(uv.x / (length(uv)));
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = fragCoord/iResolution.xy;
    uv -= 0.5;
    uv.x *= iResolution.x/iResolution.y;
    
    uv /= pow(PHI, mod(iTime, 4.));

    vec3 col = vec3(1., 1., 0.);
    
    float a = 8., b = 8.;
    int iterations = 64;
    
    float mask = 0.;
    for (int i = 0; i < iterations; i++) {
        float pt = smoothstep(0., sqrt(b), length(uv)) ;
        float pt2 = smoothstep(0., sqrt(b / PHI), length(uv));
        float pct = smoothstep(0., radians(90.), radiusAngle(uv));
        float msk = ellipseQuarter(uv, a, b, 0.01) * mix(pt, pt2, pct);
        mask = msk == 0. ? mask : msk;
        a = b;
        b /= PHI;
        uv = rotate(uv, radians(-90.));

    }

    fragColor = vec4(col * mask,1.0);
}