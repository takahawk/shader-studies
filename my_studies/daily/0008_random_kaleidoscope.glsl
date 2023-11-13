vec3 brightPink = vec3(244./255., 91./255., 105./255.);
vec3 pear = vec3(193./255., 223./255., 31./255.);
vec3 teaGreen = vec3(218. /255., 254./255., 183./255.);
vec3 pennBlue = vec3(10./255., 16./255., 69./255.);
vec3 cyclamen = vec3(239./255., 112./255., 157./255.);
vec3 eerieBlack = vec3(26./255., 29./255., 26./255.);

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = fragCoord/iResolution.xy;
    uv -= 0.5;
    vec2 uv0 = uv;
    
    uv = vec2(uv.x * cos(iTime) - uv.y * sin(iTime),
              uv.y * cos(iTime) + uv.x * sin(iTime ));
    
    float r = sqrt(uv.x * uv.x + uv.y * uv.y);
    uv.x *= (.5 - r);
    uv.y *= (.5 - r);
    
    float scale = mod(iTime, 4.);
    if (scale > 2.)
        scale = 4. - scale;
    uv *= scale;
    float step = 0.02;
    
    float mask = mod(uv.x, step) < 0.005 && mod(uv.y, step) < 0.005 ? 1. : 0.;
    vec3 col = mix(brightPink, pear, r);
    
    col = mix(col, vec3(228./255., 253./255., 225./255.), 0.125 * sin(iTime));
    
    if (uv0.x < 0.) {
        col = mix(col, teaGreen, 2. * sqrt(-uv0.x));
    } else {
        col = mix(col, pennBlue, 2. * sqrt(uv0.x));
    }
    
    
    if (uv0.y < 0.) {
        col = mix(col, cyclamen, 2. * sqrt(-uv0.y));
    } else {
        col = mix(col, eerieBlack, sqrt(uv0.y));
    }
    
    // Output to screen
    fragColor = vec4(col * mask,1.0);
}