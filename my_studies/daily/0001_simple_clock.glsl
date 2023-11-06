// A Simple Clock
// Nov 6, 2023

float line(vec2 uv, vec2 a, vec2 b, float thickness) {
    if (uv.x < min(a.x, b.x) - thickness || uv.x > max(a.x, b.x) + thickness)
        return 0.;
    if (uv.y < min(a.y, b.y) - thickness || uv.y > max(a.y, b.y) + thickness)
        return 0.;
    float mask = 1. - step(thickness, abs((uv.x - a.x) - (uv.y - a.y) * ((b.x - a.x) / (b.y - a.y))));
    
    return mask;
}

float circle(vec2 uv, float r, float thickness) {
    return 1. - step(thickness, abs(length(uv) - r));
}

float fillCircle(vec2 uv, float r) {
    return step(0., r - length(uv));
}

vec2 rotate(vec2 uv, float angle) {
    return vec2(uv.x * cos(angle) - uv.y * sin(angle),
                uv.y * cos(angle) + uv.x * sin(angle));
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = fragCoord/iResolution.xy;
    uv -= 0.5;
    uv *= 2.;
    uv.x *= iResolution.x/iResolution.y;

    vec3 whiteColor = vec3(1., 1., 1.);
    vec3 woodColor = vec3(0.243,0.098,0.);
    vec3 goldColor1 = vec3(1.,0.863,0.451);
    vec3 goldColor2 = vec3(1.,0.812,0.251);
    vec3 goldColor3 = vec3(1.,0.749,0.);

    // Time varying pixel color
    vec3 col = circle(uv, 0.5, 0.02) * woodColor;
    
    col += fillCircle(uv, 0.5 - 0.02) * whiteColor;
    
    vec2 uv2 = uv;
    for (float i = 0.; i < 12.; i += 1.) {
        float thickness = mod(i, 3.) == 0. ? 0.005 : 0.003;
        float len = mod(i, 3.) == 0. ? 0.1 : 0.07;
        col -= line(uv2, vec2(0., 0.4 - len), vec2(0., 0.4), thickness);
        uv2 = rotate(uv2, radians(360. / 12.));
    }
    
    // second arrow
    vec3 col2 = line(rotate(uv, floor(mod(iTime, 60.)) * radians(360. / 60.)), 
                vec2(0., 0.), vec2(0., 0.4), 0.005) * goldColor1;
    if (length(col2) > 0.0)
        col = col2;
        
    // minute arrow
    col2 = line(rotate(uv, mod(iTime / 60., 60.) * radians(360. / 60.)), 
                vec2(0., 0.), vec2(0., 0.4), 0.01) * goldColor2;
    if (length(col2) > 0.0)
        col = col2;

    // hour arrow
    col2 = line(rotate(uv, mod(iTime / 3600., 60.) * radians(360. / 60.)), 
                vec2(0., 0.), vec2(0., 0.4), 0.02) * goldColor3;
    if (length(col2) > 0.0)
        col = col2;

    // Output to screen
    fragColor = vec4(col,1.0);
}