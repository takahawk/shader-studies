#define PHI 1.6180339887498948482

vec3 pal( in float t, in vec3 a, in vec3 b, in vec3 c, in vec3 d )
{
    return a + b*cos( 6.28318*(c*t+d) );
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = fragCoord/iResolution.xy;
    uv -= 0.5;
    uv *= 2.;
    uv.x *= iResolution.x/iResolution.y;
    
    float t = iTime;
    vec2 p = vec2(0.0);
    float r = 1.;
    float mask = 0.;
    bool flag = true;
    float blur = 0.02;
    
    t = sin(t);
    uv *= t;
    blur *= abs(t);
    for (int i; i < 16; i++) {
        mask += smoothstep(blur, 0., abs(r - sqrt((uv.x * uv.x) + (uv.y * uv.y))));
        
        mask += smoothstep(-blur, -1., sqrt((uv.x * uv.x) + (uv.y * uv.y)) - r);
        
            mask += step(-blur, r - sqrt((uv.x * uv.x) + (uv.y * uv.y))) * 0.0625;
        
        r /= PHI;
        uv.x += (flag ? 1. : -1.) * r / PHI;
        flag = !flag;
        
        
    }
    vec3 a = vec3(0.8, 0.5, 0.4);
    vec3 b = vec3(0.2, 0.4, 0.2);
    vec3 c = vec3(2.0, 1.0, 1.0);
    vec3 d = vec3(0.00, 0.25, 0.25);
    
    
    vec3 col = pal(t, a, b, c, d) * mask;

    // Output to screen
    fragColor = vec4(col,1.0);
}