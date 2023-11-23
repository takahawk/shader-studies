float directionAngle(vec2 uv) {
    float theta = abs(atan(uv.y / uv.x));
    if (uv.x > 0.) {
        if (uv.y > 0.) {
            // 1 quadrant
        } else {
            // 4 quadrant
            theta = radians(360.) - theta;
        }
    } else {
        if (uv.y > 0.) {
            // 2 quadrant
            theta = radians(180.) - theta;
        } else {
            // 3 quadrant
            theta = radians(180.) + theta;
        }
    }
    
    return theta;
}

vec2 rotate(vec2 uv, float fi) {
    return vec2(uv.x * cos(fi) - uv.y * sin(fi),
                uv.y * cos(fi) + uv.x * sin(fi));
}


void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = fragCoord/iResolution.xy;
    uv -= 0.5;
    uv.x *= iResolution.x/iResolution.y;

    uv = rotate(uv, mod(iTime, radians(360.)));
    int maxPetals = 9;
    float maxRadius = 0.25;
    float fi = directionAngle(uv);
    float mask = 0.;
    vec3 col = vec3(0.);
    for (int i = 0; i < 10; i++) {
        float petals = floor(mod(iTime, float(maxPetals)));
        float varRadius = mod(iTime / 50., 0.01);
        float baseRadius = float(i) * maxRadius / 10. + pow(1.25, 9. - float(i)) * varRadius;
        float r = baseRadius - sin(fi * petals) * 0.25;
        vec3 color = vec3(sin(float(i) / 10.), abs(uv.x) / 1., abs(uv.y) / 1.);
        mask = 1.0 - step(0.01, abs(r - length(uv))); 
        col += mask * color;
    }

    // Output to screen
    fragColor = vec4(col,1.0);
}