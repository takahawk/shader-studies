float verticalLine(vec2 uv, float x, float y1, float y2, float blur) {
    if (uv.y < y1 || uv.y > y2)
        return 0.;
    float mask = smoothstep(blur, 0., abs(uv.x - x));
    return mask;
}

vec2 rotate(vec2 uv, float t) {
    return vec2(uv.x * cos(t) - uv.y * sin(t),
                uv.y * cos(t) + uv.x * sin(t));
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = fragCoord/iResolution.xy;
    uv -= 0.5;
    uv *= 2.;
    vec2 uv0 = uv;

    uv.x *= smoothstep(-1.4, 0.3, uv.y);
    float mask = verticalLine(uv, 0., -0.75, 0., 0.04);
    vec3 col = vec3(1., 1., 1.);
    
    uv = rotate(uv0, radians(90.));
    uv.x *= smoothstep(-0.5, 0.3, uv.y);
    mask += verticalLine(uv, 0., -0.25, 0., 0.04);
    
    uv = rotate(uv0, radians(-90.)); 
    uv.x *= smoothstep(-0.5, 0.3, uv.y);
    mask += verticalLine(uv, 0., -0.25, 0., 0.04);
    
    uv = rotate(uv0, radians(180.));
    uv.x *= smoothstep(-1.0, 0.3, uv.y);
    mask += verticalLine(uv, 0., -0.5, 0., 0.04);

    // Output to screen
    fragColor = vec4(mask * col,1.0);
}