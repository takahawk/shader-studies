float distanceTo(vec3 ro, vec3 rd, vec3 p) {
    return length(cross(p - ro, rd)) / length(rd);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = fragCoord/iResolution.xy;
    uv -= 0.5;
    uv *= 2.;
    
    vec3 a = vec3(-0.5, -0.5, 1.);
    vec3 b = vec3(-0.5,  0.5, 1.);
    vec3 c = vec3( 0.5,  0.5, 1.);
    vec3 d = vec3( 0.5, -0.5, 1.);
    
    vec3 e = vec3(-0.5, -0.5, 2.);
    vec3 f = vec3(-0.5,  0.5, 2.);
    vec3 g = vec3( 0.5,  0.5, 2.);
    vec3 h = vec3( 0.5, -0.5, 2.);
    
    vec3 col = vec3(1., 1., 1.);
    
    vec3 ro = vec3(0., 0., -2.);
    vec3 rd = vec3(uv, 0.) - ro;
    
    fragColor = vec4(col, 1.);
}