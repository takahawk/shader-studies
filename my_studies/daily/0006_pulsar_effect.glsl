#define PI 3.1415926538

float rand(vec2 co){
    return fract(sin(dot(co, vec2(12.9898, 78.233))) * 43758.5453);
}

float pulsar(vec2 uv, float t) {
    float th = PI / 6. + t;
    uv.x = uv.x * cos(th) - uv.y * sin(th);
    uv.y = uv.y * cos(th) + uv.x * sin(th);
    
    float line = smoothstep(0.02, 0., abs(sin(uv.x) - uv.y));
    
    return line;
}

float pulsar2(vec2 uv, float t) {
    // let's try to do it without domain distortion
    float th = PI / 6. + t;
    
    float line = smoothstep(0.02, 0., 
                            abs(sin(uv.x * cos(th) - uv.y * sin(th)) - 
                                uv.y * cos(th) + uv.x * sin(th)));
    // we lost rotation
    // it is because it doesn't calculated right in the first place
    // but pulsation is still here and it is awesome
    return line;
}

float pulsar1d5(vec2 uv, float t) {
    // this is version without domain distortion, but with rotation
    float th = PI / 6. + t;
    
    float a = uv.x * cos(th) - uv.y * sin(th);
    float b = uv.y * cos(th) + a * sin(th);
    
    float line = smoothstep(0.02, 0., abs(sin(a) - b));
    
    return line;
}

vec3 colorPulsar(vec3 col1, vec3 col2, float t) {
    float th = PI / 6. + t;
    
    vec3 a = col1 * cos(th) - col2 * sin(th);
    vec3 b = col2 * cos(th) + col1 * sin(th);
    
    vec3 pt = smoothstep(0.0, 1., abs(sin(a)));
    vec3 col = mix(col1, col2, pt);
    
    // well, mb, it has no use at all
    return col;
}

float pulsar3(vec2 uv, float t) {
    float th = PI / 6. + t;
    
    // found interesting effect
    float q = 5.;
    float a = uv.x * cos(th) - q * uv.y * sin(th);
    float b = uv.y * cos(th) + a * sin(th);
    
    float line = smoothstep(0.02, 0., abs(sin(a) - b));
    
    return line;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = fragCoord/iResolution.xy;
    uv -= 0.5;
    // uv.x *= iResolution.x/iResolution.y;
    vec3 col = vec3(0.);
    if (uv.x < 0.) {
        uv.x += 0.25;
        if (uv.y > 0.) {
            uv.y -= 0.25;
            uv *= 2.;
            col = pulsar1d5(uv, iTime) * vec3(1., 0., 0.);
        } else {
            col = colorPulsar(vec3(0., 1., 0.), vec3(0., 0., 1.), iTime);
        }
    } else {
        uv.x -= 0.25;
        if (uv.y > 0.) {
            uv.y -= 0.25;
            uv *= 2.;
            col = pulsar2(uv, iTime) * vec3(0., 1., 0.);
        } else {
            uv.y += 0.25;
            uv *= 2.;
            col = pulsar3(uv, iTime) * vec3(0., 0., 1.);
        }
    }
    
    fragColor = vec4(col,1.0);
}