float inBounds(vec2 uv, vec2 p1, vec2 p2) {
    return (uv.x < max(p1.x, p2.x) && 
            uv.x > min(p1.x, p2.x) &&
            uv.y < max(p1.y, p2.y) &&
            uv.y > min(p1.y, p2.y)) ? 1. : 0.;
}

float hline(vec2 uv, float t, float thickness) {
    if (uv.x < 0. || uv.x > 1.)
        return 0.;
    return step(-thickness / 2., -abs(uv.y)) * step(t, 1. - uv.x);
}

vec2 rotate(vec2 uv, float angle) {
    return vec2(uv.x * cos(angle) - uv.y * sin(angle),
                uv.y * cos(angle) + uv.x * sin(angle));
}

// copy pixels from (0., -thickness / 2.) to (1., thickness / 2.) to line ab
vec2 withCopiedFromXAxis(vec2 uv, vec2 a, vec2 b, float thickness) {
    float offsetX = abs(uv.x - thickness);
    float offsetY = abs(uv.y - thickness);
    if (uv.x < 1. && uv.x > 0. && uv.y < thickness / 2. && uv.y > - thickness / 2.)
        return uv;
    bool sameX = a.x == b.x;
    bool sameY = a.y == b.y;
    float x, y;
    x = a.x + (uv.y - a.y) * (b.x - a.x) / (b.y - a.y);
    y = a.y + (uv.x - a.x) * (b.y - a.y) / (b.x - a.x);
    
    if (!sameX && abs(uv.y - y) > thickness / 2.)
        return uv;
    if (!sameY && abs(uv.x - x) > thickness / 2.)
        return uv;
    
    float res;
    if (!sameX)
        res = (uv.x - a.x) / (b.x - a.x);
    else
        res = (uv.y - a.y) / (b.y - a.y);
    
    if (res < 0. || res > 1.)
        return uv;
    
    return vec2(res, 0.);
}

float hagalaz(vec2 uv0, float t, float thickness) {
    vec2 uv = uv0;
      
    uv.x += 0.5;
    uv.y -= 1.;
    uv.y /= 2.;
    uv = rotate(uv, radians(90.));
    uv = withCopiedFromXAxis(uv, vec2(0., 1.0), vec2(1., 1.0), thickness);
    uv = withCopiedFromXAxis(uv, vec2(0.25, 0.), vec2(.75, 1.0), thickness);
    float mask = hline(uv, t, thickness);
    return mask;
}

float nauthiz(vec2 uv0, float t, float thickness) {
    vec2 uv = uv0;
    uv.y -= 1.;
    uv.y /= 2.;
    
    uv = rotate(uv, radians(90.));
    uv = withCopiedFromXAxis(uv, vec2(0.25, -0.5), vec2(0.75, 0.5), thickness);
    
    float mask = hline(uv, t, thickness);
    return mask;
}

float isa(vec2 uv0, float t, float thickness) {
    vec2 uv = uv0;
    uv.y -= 1.;
    uv.y /= 2.;
    uv = rotate(uv, radians(90.));
    
    float mask = hline(uv, t, thickness);
    return mask;
}

float jera(vec2 uv0, float t, float thickness) {
    vec2 uv = uv0;
    uv.x += 0.5;
    uv.y -= 1. / 3.;
    uv /= cos(radians(45.));
    uv = rotate(uv, radians(-45.));
    uv = withCopiedFromXAxis(uv, vec2(0., 0.), vec2(0., -1.), thickness);
    uv = withCopiedFromXAxis(uv, vec2(0.5, -1.5), vec2(0.5, -0.5), thickness);
    uv = withCopiedFromXAxis(uv, vec2(0.5, -1.5), vec2(-0.5, -1.5), thickness);
    
    float mask = hline(uv, t, thickness);
    return mask;
}

float eihwaz(vec2 uv0, float t, float thickness) {
    vec2 uv = uv0;
    uv.y -= 1.;
    uv.y /= 2.;
    
    uv = rotate(uv, radians(90.));
    uv = withCopiedFromXAxis(uv, vec2(0., 0.), vec2(0.5, 0.5), thickness);
    uv = withCopiedFromXAxis(uv, vec2(1., 0.), vec2(0.5, -0.5), thickness);
    
    float mask = hline(uv, t, thickness);
    return mask;
}

float pertho(vec2 uv0, float t, float thickness) {
    vec2 uv = uv0;
    uv.y -= 1.;
    uv.x += 0.5;
    uv.y /= 2.;
    
    uv = rotate(uv, radians(90.));
    uv = withCopiedFromXAxis(uv, vec2(0., 0.), vec2(0.25, 0.5), thickness);
    uv = withCopiedFromXAxis(uv, vec2(1., 0.), vec2(0.75, 0.5), thickness);
    uv = withCopiedFromXAxis(uv, vec2(0.25, 0.5), vec2(0., 1.0), thickness);
    uv = withCopiedFromXAxis(uv, vec2(0.75, 0.5), vec2(1., 1.0), thickness);
    
    float mask = hline(uv, t, thickness);
    return mask;
}

float algiz(vec2 uv0, float t, float thickness) {
    vec2 uv = uv0;
    uv.y -= 1.;
    uv.y /= 2.;
    
    uv = rotate(uv, radians(90.));
    uv = withCopiedFromXAxis(uv, vec2(0.25, 0.), vec2(0., -0.5), thickness);
    uv = withCopiedFromXAxis(uv, vec2(0.25, 0.), vec2(0., 0.5), thickness);
    
    float mask = hline(uv, t, thickness);
    return mask;
}

float sowulo(vec2 uv0, float t, float thickness) {
    vec2 uv = uv0;
    uv.y -= 1./3.;
    uv.x += 0.25;
    
    uv = rotate(uv, radians(-45.));
    
    uv = withCopiedFromXAxis(uv, vec2(0., 0.), vec2(0., -1.), thickness);
    uv = withCopiedFromXAxis(uv, vec2(0., -1.), vec2(-1., -1.), thickness);
    
    float mask = hline(uv, t, thickness);
    return mask;
    
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv0 = fragCoord/iResolution.xy;
    uv0 -= 0.5;
    uv0 *= 2.;
    uv0.x *= iResolution.x / iResolution.y;
    
    float angle = mod(iTime, radians(360.));
    float r = 0.5;
    float step = radians(360.) / 8.;
    float mask = 0.;
    float scale = 0.125;
    
    vec2 uv = uv0;

    uv.x += sin(angle) * r;
    uv.y += cos(angle) * r;
    uv /= scale;
    mask += hagalaz(uv, 1.  - mod(iTime, 2.0), 0.09);
    angle += step;
    
    uv = uv0;
    uv.x += sin(angle) * r;
    uv.y += cos(angle) * r;
    uv /= scale;
    mask += nauthiz(uv, 1.  - mod(iTime, 2.0), 0.09);
    angle += step;
    
    uv = uv0;
    uv.x += sin(angle) * r;
    uv.y += cos(angle) * r;
    uv /= scale;
    mask += isa(uv, 1.  - mod(iTime, 2.0), 0.09);
    angle += step;
    
    uv = uv0;
    uv.x += sin(angle) * r;
    uv.y += cos(angle) * r;
    uv /= scale;
    mask += jera(uv, 1.  - mod(iTime, 2.0), 0.09);
    angle += step;
    
    uv = uv0;
    uv.x += sin(angle) * r;
    uv.y += cos(angle) * r;
    uv /= scale;
    mask += eihwaz(uv, 1.  - mod(iTime, 2.0), 0.09);
    angle += step;
    
    uv = uv0;
    uv.x += sin(angle) * r;
    uv.y += cos(angle) * r;
    uv /= scale;
    mask += pertho(uv, 1.  - mod(iTime, 2.0), 0.09);
    angle += step;
    
    uv = uv0;
    uv.x += sin(angle) * r;
    uv.y += cos(angle) * r;
    uv /= scale;
    mask += algiz(uv, 1.  - mod(iTime, 2.0), 0.09);
    angle += step;
    
    uv = uv0;
    uv.x += sin(angle) * r;
    uv.y += cos(angle) * r;
    uv /= scale;
    mask += sowulo(uv, 1.  - mod(iTime, 2.0), 0.09);
    angle += step;
    

    vec3 col = vec3(1., 1., 0.);

    // Output to screen
    fragColor = vec4(col * mask,1.0);
}