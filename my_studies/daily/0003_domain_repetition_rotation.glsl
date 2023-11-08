#define PI 3.1415926535897932384626433832795
vec2 rotate(vec2 uv, float angle) {
    return vec2(uv.x * cos(angle) - uv.y * sin(angle),
                uv.y * cos(angle) + uv.x * sin(angle));
}

float angleBetween(vec2 a, vec2 b) {
    return acos(dot(a, b) / 
           (length(a) * length(b)));
}

vec2 repeatWithRotation(vec2 uv, float angle) {
    if (uv.y < 0.)
        uv = rotate(uv, radians(180.));
    float angle2 = angleBetween(vec2(1., 0.), uv);

    uv = rotate(uv, -floor(angle2 / angle) * angle);
    
    return uv;
}


bool isBySameSide(vec2 a, vec2 b, vec2 p1, vec2 p2) {
    float ratio = (b.x - a.x) / (b.y - a.y);
    float first = (p1.x - a.x) - (p1.y - a.y) * ratio;
    float second = (p2.x - a.x) - (p2.y - a.y) * ratio;
    return (first > 0.) == (second > 0.);
}

float triangle(vec2 uv, vec2 a, vec2 b, vec2 c, float blur) {
    if (isBySameSide(a, b, c, uv) && isBySameSide(a, c, b, uv) && isBySameSide(b, c, a, uv))
        return 1.;
    return 0.;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = fragCoord/iResolution.xy;
    uv -= 0.5;
    uv *= 3.0;
    uv.x *= iResolution.x/iResolution.y;
    uv = repeatWithRotation(uv, radians(46.));

    vec2 a = vec2(0.,0.);
    vec2 b = vec2(1., 0.);
    vec2 c = vec2(cos(radians(45.)), sin(radians(45.)));
    vec3 col = mix(vec3(0.7,0.6,0.1), pow(length(uv), 2.) * vec3(0.7,0.2,0.2), sin(iTime));

    float mask = triangle(uv, a, b, c, 0.01);

    // Output to screen
    fragColor = vec4(col * mask,1.0);
}