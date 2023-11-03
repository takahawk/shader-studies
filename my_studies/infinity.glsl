#define PI 3.1415926535897932384626433832795

vec2 rotate(vec2 uv, float angle) {
    return vec2(
        uv.x * cos(angle) - uv.y * sin(angle),
        uv.y * cos(angle) + uv.x * sin(angle)
    );
}

vec3 infinity(vec2 uv, float blur, float t) {
    float y = abs(uv.x) * sqrt(1. - abs(uv.x));
    float mask = smoothstep(y - blur, y, abs(uv.y)) - smoothstep(y, y + blur, abs(uv.y));
    
    float glow = smoothstep(t - blur * 2., t, uv.x) - smoothstep(t, t + blur * 2., uv.x);
    
    return mask * vec3(0., 0., 1.) + mask * glow * vec3(1., 1., 0.);
}

vec3 sun(vec2 uv, vec2 p, float blur) {
    float mask = 0.;
    int sections = 2;
    
    uv -= p;
    uv *= 8.;
    //if (uv.y < 0.)
    //    return vec3(0.);
    
    for (int i = 0; i < sections; i++) {
        float y = 1. - abs(uv.x * 4.);
        mask += 1. - step(y, uv.y) * step(0., uv; // - smoothstep(y, y + blur, uv.y);
        uv = rotate(uv, PI / float(sections));
    }
    
    return mask * vec3(1., 1., 0.);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = fragCoord/iResolution.xy;
    
    float t = sin(3. * iTime);
    uv -= 0.5;
    uv.x *= iResolution.x/iResolution.y;
    uv *= 2.;
    
    vec3 col = vec3(0.);
    col += infinity(uv, 0.07, t);
    col += sun(uv, vec2(-0.5, 0.), 0.02);
    
    fragColor = vec4(col, 1.);
}