vec3 darkGolden = vec3(166./255.,124./255.,0.);
vec3 brightGolden = vec3(255./255.,191./255.,0.);


float hline(vec2 uv, float blur) {
    return smoothstep(blur, 0., abs(uv.y));
}

vec2 rotate(vec2 uv, float t) {
    return vec2(uv.x * cos(t) - uv.y * sin(t),
                uv.y * cos(t) + uv.x * sin(t));
}

float inBounds(vec2 uv, vec2 p1, vec2 p2) {
    if (uv.x < min(p1.x, p2.x))
        return 0.;
    if (uv.x > max(p1.x, p2.x))
        return 0.;
    if (uv.y < min(p1.y, p2.y))
        return 0.;
    if (uv.y > max(p1.y, p2.y))
        return 0.;
    return 1.;
}

float rune(vec2 uv, float mask, float blur) {
    vec2 bound1 = vec2(-0.5, -1.) - blur / 2.;
    vec2 bound2 = vec2(0.5, 1.) + blur / 2.;

    return mask * inBounds(uv, bound1, bound2);
}

float fehu(vec2 uv0, float blur) {
    vec2 uv = uv0;
    uv.x += 0.5;
    uv = rotate(uv, radians(90.));
    float mask = hline(uv, blur);
    uv = rotate(uv, radians(45.));
    mask += hline(uv, blur);
    uv.y += 0.3;
    mask += hline(uv, blur);
    return rune(uv0, mask, blur);
}

float uruz(vec2 uv0, float blur) { 
    vec2 uv = uv0;
    uv.x += 0.5;
    uv = rotate(uv, radians(90.));
    float mask = hline(uv, blur) ;
    
    uv.y -= 1.;
    mask += hline(uv, blur)  * inBounds(uv0, vec2(-1.), vec2(1., 0.42));
    
    uv = rotate(uv, radians(-60.));
    uv.y -= 0.35;
    mask += hline(uv, blur); 
    
    return rune(uv0, mask, blur);
}

float thurisaz(vec2 uv0, float blur) {
    vec2 uv = uv0;
    uv = rotate(uv + 0.5, radians(90.));
    float mask = hline(uv, blur);
    
    uv = uv0;
    uv.y += 0.305;
    uv = rotate(uv, radians(-30.));
    mask += hline(uv, blur);
    
    uv = uv0;
    uv.y -= 0.305;
    uv = rotate(uv, radians(30.));
    mask += hline(uv, blur);
    
    return rune(uv0, mask, blur);
}

float ansuz(vec2 uv0, float blur) {
    vec2 uv = uv0;
    uv.x += 0.5;
    uv = rotate(uv, radians(90.));
    float mask = hline(uv, blur);
    
    uv = uv0;
    uv.y -= 1.;
    uv.x += 0.5;
    uv = rotate(uv, radians(30.));
    mask += hline(uv, blur);
    
    uv = uv0;
    uv.y -= 0.25;
    uv.x += 0.5;
    uv = rotate(uv, radians(30.));
    mask += hline(uv, blur);
    
    return rune(uv0, mask, blur);
}

float raido(vec2 uv0, float blur) {
    vec2 uv = uv0;
    uv.x += 0.5;
    uv = rotate(uv, radians(90.));
    float mask = hline(uv, blur);
    
    uv = uv0;
    uv.x += 0.5;
    uv.y -= 1.;
    uv = rotate(uv, radians(30.));
    mask += hline(uv, blur);
    
    uv = uv0;
    uv.x += 0.5;
    uv.y += 0.2;
    uv = rotate(uv, radians(-30.));
    mask += hline(uv, blur);
    
    uv = uv0;
    uv.x += 0.5;
    uv.y += 0.2;
    uv = rotate(uv, radians(38.));
    mask += hline(uv, blur);
    
    return rune(uv0, mask, blur);
}

float kenaz(vec2 uv0, float blur) {
    vec2 uv = uv0;
    uv.x += 0.5;
    uv = rotate(uv, radians(45.));
    float mask = hline(uv, blur);
    
    uv = rotate(uv, radians(-90.));
    mask += hline(uv, blur);
    
    return rune(uv0, mask, blur);
}

float gebo(vec2 uv0, float blur) {
    vec2 uv = uv0;
    uv = rotate(uv, radians(62.));
    float mask = hline(uv, blur);
    uv = rotate(uv, radians(-124.));
    mask += hline(uv, blur);
    
    return rune(uv0, mask, blur);
}

float wunjo(vec2 uv0, float blur) {
    vec2 uv = uv0;
    uv.x += 0.5;
    uv = rotate(uv, radians(90.));
    float mask = hline(uv, blur);
    
    uv = uv0;
    uv.x += 0.5;
    uv.y -= 1.;
    uv = rotate(uv, radians(30.));
    mask += hline(uv, blur);
    
    uv = uv0;
    uv.x += 0.5;
    uv.y += 0.2;
    uv = rotate(uv, radians(-30.));
    mask += hline(uv, blur);
    
    return rune(uv0, mask, blur);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv0 = fragCoord/iResolution.xy;
    uv0 -= .5;
    uv0.x *= iResolution.x / iResolution.y;
    uv0 *= 2.;

    float r = 0.6;
    float step = -radians(360.) / 8.;
    float blur = 0.05 + mod(iTime / 10., 0.15);
    vec3 col = mix(darkGolden, brightGolden, mod(iTime / (0.15) / 10., 1.));
    float scale = 8.;
    
    float angle = -mod(iTime / 5., radians(360.));
    float mask = 0.;
    
    vec2 uv = uv0;
    uv.x -= cos(angle) * r;
    uv.y -= sin(angle) * r;
    uv *= scale;
    mask = fehu(uv, blur);
    
    
    angle += step;
    uv = uv0;
    uv.x -= cos(angle) * r;
    uv.y -= sin(angle) * r;
    uv *= scale;
    mask += uruz(uv, blur);
    
    angle += step;
    uv = uv0;
    uv.x -= cos(angle) * r;
    uv.y -= sin(angle) * r;
    uv *= scale;
    mask += thurisaz(uv, blur);
    
    angle += step;
    uv = uv0;
    uv.x -= cos(angle) * r;
    uv.y -= sin(angle) * r;
    uv *= scale;
    mask += ansuz(uv, blur);
    
    angle += step;
    uv = uv0;
    uv.x -= cos(angle) * r;
    uv.y -= sin(angle) * r;
    uv *= scale;
    mask += raido(uv, blur);
    
    angle += step;
    uv = uv0;
    uv.x -= cos(angle) * r;
    uv.y -= sin(angle) * r;
    uv *= scale;
    mask += kenaz(uv, blur);
    
    angle += step;
    uv = uv0;
    uv.x -= cos(angle) * r;
    uv.y -= sin(angle) * r;
    uv *= scale;
    mask += gebo(uv, blur);
    
    angle += step;
    uv = uv0;
    uv.x -= cos(angle) * r;
    uv.y -= sin(angle) * r;
    uv *= scale;
    mask += wunjo(uv, blur);
    
    
    // Output to screen
    fragColor = vec4(col * mask,1.0);
}