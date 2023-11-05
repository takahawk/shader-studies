vec3 palette( in float t, in vec3 a, in vec3 b, in vec3 c, in vec3 d )
{
    return a + b*cos( 6.28318*(c*t+d) );
}

float line(vec2 uv, vec2 a, vec2 b, float blur) {
    float mask = smoothstep(blur, 0., abs((uv.x - a.x) - (uv.y - a.y) * ((b.x - a.x) / (b.y - a.y))));
    mask += smoothstep(blur, 0., abs((uv.y - a.y) - (uv.x - a.x) * ((b.y - a.y) / (b.x - a.x))));
    
    float minx = min(a.x, b.x);
    mask *= smoothstep(-blur * 10., 0., uv.x - minx);
    float maxx = max(a.x, b.x);
    mask *= smoothstep(blur * 10., 0., uv.x - maxx);
    float miny = min(a.y, b.y);
    mask *= smoothstep(-blur * 10., 0., uv.y - miny);
    return mask;
}

float triangle(vec2 uv, vec2 a, vec2 b, vec2 c, float blur) {
    float mask = line(uv, a, b, blur);
    mask += line(uv, b, c, blur);
    mask += line(uv, a, c, blur);
    return mask;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = fragCoord/iResolution.xy;
    uv -= 0.5;
    vec3 col = vec3(0.0);
    uv.x *= iResolution.x/iResolution.y;
    float t = sin(iTime);
    uv.y -= t / 4.;
    uv *= t;
    float blur = abs(0.02);
    
    vec3 a = vec3(0.5, 0.5, 0.5);
    vec3 b = vec3(0.5, 0.5, 0.5);
    vec3 c = vec3(2.0, 1.0, 0.0);
    vec3 d = vec3(0.50, 0.20, 0.25);
    

    for (int i = 0; i < 32; i++) {
        float factor = (float(i) / 6.) / t;
        vec3 pal = palette(factor, a, b, c, d);
        col += triangle(uv, vec2(-0.5, -0.5), vec2(0., .5), vec2(0.5, -0.5), blur) *
               pal;
        
        uv.y += 0.25;
        uv *= 2.;
        float th = radians(180.);
        uv.x = uv.x * cos(th) - uv.y * sin(th);
        uv.y = uv.y * cos(th) + uv.x * sin(th);
    }
    

    // Output to screen
    fragColor = vec4(col,1.0);
}