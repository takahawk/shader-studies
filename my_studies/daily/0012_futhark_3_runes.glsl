// draw vertical line segment y = [0..1] 
float vline(vec2 uv, float thickness) {
    return (step(0., uv.y) - step(1., uv.y)) * 
           (step(-thickness/2., uv.x) - step(thickness / 2., uv.x));
}

float teiwaz(vec2 uv, float thickness) {
    mat3 first = mat3(1., 0., 0.,
                      0., 1., 0.,
                      0., .5, 1.);
    
    uv = vec2(first * vec3(uv, 1.));
    float mask = vline(uv, thickness);
    
    float angle = radians(-135.);
    mat3 second = mat3(cos(angle), -sin(angle), 0.,
                       sin(angle), cos(angle), 0.,
                       0., 0.0, 1.) *
                  mat3(2., 0.,  0.,
                       0.,  2., 0.,
                       0.,  0.,  1.) *
                  mat3(1., 0., 0.,
                       0., 1., 0.,
                       0.0, -1.0, 1.);       
    uv = vec2(second * vec3(uv, 1.));
    mask += vline(uv, thickness * 2.);
    
    angle = radians(-90.);
    mat3 third = mat3(cos(angle), -sin(angle), 0.,
                      sin(angle), cos(angle), 0.,
                      0., 0., 1.);
    uv = vec2(third * vec3(uv, 1.));
    mask += vline(uv, thickness * 2.);
    
    return mask;
}

float berkana(vec2 uv, float thickness) {
    mat3 first = mat3(1., 0., 0.,
                      0., 1., 0.,
                      0.125, .5, 1.);
                      
    uv = vec2(first * vec3(uv, 1.));
    float mask = vline(uv, thickness);
    
    float angle = radians(-60.);
    float scale = 2.;
    mat3 second = mat3(cos(angle), -sin(angle), 0.,
                       sin(angle), cos(angle), 0.,
                       0., 0., 1.) *
                  mat3(scale, 0., 0.,
                       0., scale, 0.,
                       0., 0., 1.);
    uv = vec2(second * vec3(uv, 1.));
    mask += vline(uv, thickness);
    
    angle = radians(120.);
    mat3 third = mat3(cos(angle), -sin(angle), 0.,
                      sin(angle), cos(angle), 0.,
                      0., 0., 1.) *
                 mat3(1., 0., 0.,
                      0., 1., 0.,
                      0., -1., 1.);
    uv = vec2(third * vec3(uv, 1.));
    mask += vline(uv, thickness);
    
    angle = radians(-120.);
    mat3 fourth = mat3(cos(angle), -sin(angle), 0.,
                       sin(angle), cos(angle), 0.,
                       0., 0., 1.)
                  *
                  mat3(1., 0., 0.,
                       0., 1., 0.,
                       0., -1., 1.);
    uv = vec2(fourth * vec3(uv, 1.));
    mask += vline(uv, thickness);
    
    uv = vec2(third * vec3(uv, 1.));
    mask += vline(uv, thickness);
    
    return mask;
}

mat3 rotation(float angle) {
    angle = radians(angle);
    return mat3(cos(angle), -sin(angle), 0.,
                sin(angle), cos(angle), 0.,
                0., 0., 1.);
}

mat3 translation(float x, float y) {
    return mat3(1., 0., 0.,
                0., 1., 0.,
                -x,  -y,  1.);
}

mat3 scaling(float t) {
    return mat3(t, 0., 0.,
                0., t, 0.,
                0., 0., 1.);
}

vec2 apply(mat3 transform, vec2 p) {
    return vec2(transform * vec3(p, 1.));
}

float ehwaz(vec2 uv, float thickness) {
    uv = apply(translation(-0.25, -0.5), uv);
    float mask = vline(uv, thickness);
    uv = apply(rotation(-135.) * scaling(2.5) * translation(0., 1.), uv);
    mask += vline(uv, thickness * 2.5);
    
    uv = apply(rotation(90.) * translation(0., 1.), uv);
    mask += vline(uv, thickness * 2.5);
    
    uv = apply(rotation(-135.) * scaling(1./2.5) * translation(0., 1.), uv);
    mask += vline(uv, thickness);
    return mask;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv0 = fragCoord/iResolution.xy;
    uv0 -= 0.5;
    uv0.x *= iResolution.x / iResolution.y;
    
    float r = 0.25;
    float angle = mod(iTime, radians(360.));
    float step = radians(360.) / 3.;
    vec2 uv;
    float mask = 0.;
    
    uv = uv0;
    uv.x -= sin(angle) * r;
    uv.y -= cos(angle) * r;
    uv *= 4.;
    mask += teiwaz(uv, 0.03);
    angle += step;
    
    uv = uv0;
    uv.x -= sin(angle) * r;
    uv.y -= cos(angle) * r;
    uv *= 4.;
    mask += berkana(uv, 0.03);
    angle += step;
    
    uv = uv0;
    uv.x -= sin(angle) * r;
    uv.y -= cos(angle) * r;
    uv *= 4.;
    mask += ehwaz(uv, 0.03);
    angle += step;
    
    vec3 col = 0.5 + 0.5*cos(iTime+uv.xyx+vec3(0,2,4));

    fragColor = vec4(col * mask,1.0);
}