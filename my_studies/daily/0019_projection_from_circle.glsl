float directionAngle(vec2 uv) {
    // copied from 0017
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

vec2 rotate(vec2 uv, float angle) {
    return vec2(uv.x * cos(angle) - uv.y * sin(angle),
                uv.y * cos(angle) + uv.x * sin(angle));
}

vec2 projectToCircle(vec2 uv, float r, float startAngle) {
    // copied from 0017
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

float fillRect(vec2 uv, float a, float b) {
    return (1. - step(abs(a) / 2., abs(uv.x))) *
           (1. - step(abs(b) / 2., abs(uv.y)));
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = fragCoord/iResolution.xy;
    uv -= 0.5;
    uv.x *= iResolution.x / iResolution.y;
    
    uv *= 4.;
    float mask;
    vec3 col;
    col = 0.5 + 0.5*cos(iTime+uv.xyx+vec3(0,2,4));
    if (uv.x < 0.) {
        uv.x += 1.5;
        
        
        if (uv.y < 0.) {
            uv.y += 1.;
            uv = projectFromCircle(uv, 1., iTime);
            mask = 1. - step(0.02, abs(sin(uv.x * 10.) / 4. - uv.y));
        } else {
            uv.y -= 1.;
            uv = projectFromCircle(uv, 1., iTime);
            
            mask = fillRect(uv, 1.0, 1.);
            
        }
    } else {
        uv.x -= 1.5;
        
        if (uv.y < 0.) {
            uv.y += 1.;
            uv = projectFromCircle(uv, 1., iTime);
            uv = projectFromCircle(uv, 1., iTime);
            mask = 1. - step(0.02, abs(sin(uv.x * 10.) / 4. - uv.y));
        } else {
            uv.y -= 1.;
            uv = projectFromCircle(uv.yx, 1., iTime);
            uv = projectFromCircle(uv.yx, 1., iTime);
            mask = fillRect(uv, 1.0, 1.);
            
        }
    }

    

    // Output to screen
    fragColor = vec4(mask * col,1.0);
}