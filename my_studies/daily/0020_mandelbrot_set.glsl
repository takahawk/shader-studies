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

vec2 projectToCircle(vec2 uv, float r, float startAngle) {
    // basically using polar coordinates as cartesian
    // radius is treated as y-coordinate
    //     |uv| == 0.  => y = -1.
    //     |uv| == r   => y =  0.
    //     |uv| == 2*r => y =  1.
    // angle is treated as x-coordinate
    //     fi = 0.   => x =  0.
    //     fi = 180  => x =  1.
    //     fi = -180 => x = -1.
    float x = length(uv) / (r / 2.) -1.;
    float y = (mod(startAngle + directionAngle(uv), radians(360.)) - radians(180.)) / radians(180.);
    
    return vec2(x, y);
}

vec2 projectFromCircle(vec2 uv, float r, float startAngle) {
    // doing the reverse to projectToCircle
    // using cartesian coordinates as polar
    //
    // at first lets find those polar coordinates
    // radius
    //   x == -1. => ro = 0.
    //   x ==  0. => ro = r
    //   x ==  1. => ro = 2 * r
    float ro = (uv.x + 1.) * r;
    // angle
    //   y == -1. => fi = -180
    //   y ==  0. => fi =    0
    //   y ==  1. => fi =  180
    float fi = (uv.y + 1.) * radians(180.);
    fi = mod(fi + startAngle, radians(360.)) - radians(180.);
    
    
    // now we can convert calculated coordinates to cartesian
    return vec2(ro * cos(fi),
                ro * sin(fi));
}



float mandelbrot_n(vec2 c, int n, float r) {
    vec2 z = vec2(0.);
    for (int i = 0; i < n; i++) {
        vec2 z2 = vec2(z.x * z.x - z.y * z.y,
                       2. * z.x * z.y);
        z = z2 + c;
    }
    
    
    return step(abs(z.x), r) * z.y * 2.;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = fragCoord/iResolution.xy;
    uv -= 0.5;
    uv *= 2.;
    uv.x *= iResolution.x / iResolution.y;

    uv = projectFromCircle(uv, 1., iTime);
    uv = projectFromCircle(uv, 1., iTime);
    uv = projectToCircle(uv, 1., iTime);
    uv = projectFromCircle(uv, 1., iTime);
    uv = projectFromCircle(uv, 1., iTime);
    vec3 col = 0.5 + 0.5*cos(iTime+uv.xyx+vec3(0,2,4));
    int n = int(mod(iTime * 10., 32.));
    float r = 2.;

    // Output to screen
    fragColor = vec4(col * mandelbrot_n(uv, n, r),1.0);
}