float distanceTo(vec3 ro, vec3 rd, vec3 p) {
    return length(cross(p - ro, rd)) / length(rd);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = fragCoord/iResolution.xy;
    uv -= 0.5;
    uv *= 2.;
    uv.x *= iResolution.x / iResolution.y;

    vec3 p = vec3(sin(iTime), 0., 1. + cos(iTime));
    vec3 ro = vec3(0., 0., -2.);
    vec3 rd = vec3(uv, 0) - ro;
    
    float mask = smoothstep(0.1, .09, distanceTo(ro, rd, p));
    
    
    fragColor = vec4(vec3(1.) * mask,1.0);
}