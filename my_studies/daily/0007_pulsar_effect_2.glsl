#define PI 3.1415926538

float pulsar(vec2 uv, float t) {
    float th = PI / 6. + t;
    uv.x = uv.x * cos(th) - uv.y * sin(th);
    uv.y = uv.y * cos(th) + uv.x * sin(th);
    
    float line = smoothstep(0.02, 0., abs(sin(uv.x) - uv.y));
    
    return line;
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

float clip(float t, float lbound, float rbound) {
    return lbound + mod(t, rbound - lbound);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = fragCoord/iResolution.xy;
    uv -= 0.5;
    // uv.x *= iResolution.x / iResolution.y;
    // Time varying pixel color
    vec3 col = vec3(0.); 
    uv *= 4.;

    if (uv.y > 0.) {
        uv.y -= 1.;
        if (uv.x > 0.) {
            uv.x -= 1.;
            col = vec3(pulsar(uv, clip(iTime, 1., 2.6)));
        } else {
            uv.x += 1.;
            float t = iTime / 5.;
            col = vec3(pulsar(uv, clip(t, 1., 2.6)));
        }
    } else {
        uv.y += 1.;
        if (uv.x > 0.) {
            uv.x -= 1.;
            col = vec3(pulsar3(uv, clip(iTime, 0.2, 2.6)));
        } else {
            uv.x += 1.;
            float t = iTime / 5.;
            col = vec3(pulsar3(uv, clip(t, 0.2, 2.6)));
        }
    }
    // Output to screen
    fragColor = vec4(col,1.0);
}