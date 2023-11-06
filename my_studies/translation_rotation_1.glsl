vec2 with_translation(vec2 uv, vec2 src, vec2 dst) {
    if (length(uv - src) > length(uv - dst)) {
        return uv - (dst - src);
    }
    
    return uv;
}

vec2 with_rotation(vec2 uv, vec2 c, float angle1, float angle2) {
    uv -= c;
    float th = acos(uv.x / length(uv));
    if (abs(th - angle2) > abs(th - angle1)) {
        float diff = angle1 - angle2;
        return vec2(uv.x * cos(diff) - uv.y * sin(diff),
                    uv.y * cos(diff) + uv.y * sin(diff));
    }
    
    return uv;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = fragCoord/iResolution.xy;
    uv.x -= 0.5;
    uv.x *= iResolution.x/iResolution.y;
    uv *= 2.;
    
    uv = with_rotation(uv, vec2(0.5, 0.), radians(90.), radians(135.));
    // uv = with_translation(uv, vec2(0.5, 0.), vec2(0., 0.));
    // uv = with_translation(uv, vec2(0.5, 0.), vec2(0., 0.));
    // uv = with_translation(uv, vec2(0.5, 0.), vec2(0., 0.));
    // uv = with_translation(uv, vec2(0.5, 0.), vec2(0., 0.));
    
    float x = 0.5;
    // Time varying pixel color
    float mask = smoothstep(0.02, 0.0, abs(uv.x - x));
    vec3 col = 0.5 + 0.5*cos(iTime+uv.xyx+vec3(0,2,4));
    col = col * mask;

    // Output to screen
    fragColor = vec4(col,1.0);
}