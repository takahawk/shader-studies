float line(vec2 uv, vec2 p1, vec2 p2, float blur) {
    if (uv.x < min(p1.x, p2.x) - blur)
        return 0.;
    if (uv.x > max(p1.x, p2.x) + blur)
        return 0.;
    if (uv.y < min(p1.y, p2.y)- blur || uv.y > max(p1.y, p2.y) + blur)
        return 0.;
    float mask = smoothstep(blur, 0., abs((uv.x - p1.x) - (uv.y - p1.y) * (p2.x - p1.x) / (p2.y - p1.y)));
    mask += smoothstep(blur, 0., abs((uv.y - p1.y) - (uv.x - p1.x) * (p2.y - p1.y) / (p2.x - p1.x)));
    return mask;
}

vec2 projection(vec3 ro, vec3 p) {
    // projection to z=0 plane (screen)
    float x = (-ro.z) / (p.z - ro.z) * (p.x - ro.x) + ro.x;
    float y = (-ro.z) / (p.z - ro.z) * (p.y - ro.y) + ro.y;
    return vec2(x, y);
}

float cube(vec2 uv, vec3 ro, float a, float blur) {
    vec3 A = vec3(-a / 2., -a / 2., -a / 2.);
    vec3 B = vec3(-a / 2., -a / 2.,  a / 2.);
    vec3 C = vec3(-a / 2.,  a / 2.,  a / 2.);
    vec3 D = vec3(-a / 2.,  a / 2., -a / 2.);
    
    vec3 E = vec3(a / 2., -a / 2., -a / 2.);
    vec3 F = vec3(a / 2., -a / 2.,  a / 2.);
    vec3 G = vec3(a / 2.,  a / 2.,  a / 2.);
    vec3 H = vec3(a / 2.,  a / 2., -a / 2.);
    
    vec2 pA = projection(ro, A);
    vec2 pB = projection(ro, B);
    vec2 pC = projection(ro, C);
    vec2 pD = projection(ro, D);
    vec2 pE = projection(ro, E);
    vec2 pF = projection(ro, F);
    vec2 pG = projection(ro, G);
    vec2 pH = projection(ro, H);
    
    float mask = 0.;
    mask += line(uv, pA, pB, blur);
    mask += line(uv, pB, pC, blur);
    mask += line(uv, pC, pD, blur);
    mask += line(uv, pD, pA, blur);
    mask += line(uv, pE, pF, blur);
    mask += line(uv, pF, pG, blur);
    mask += line(uv, pG, pH, blur);
    mask += line(uv, pH, pE, blur);
    mask += line(uv, pA, pE, blur);
    mask += line(uv, pB, pF, blur);
    mask += line(uv, pC, pG, blur);
    mask += line(uv, pD, pH, blur);
    
    return mask;
}


void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = fragCoord/iResolution.xy;
    
    uv -= 0.5;
    uv.x *= iResolution.x / iResolution.y;

    vec3 ro = vec3(sin(iTime), cos(iTime), -2.);
    float mask = cube(uv, ro, 0.5, 0.02);
    vec3 col = vec3(1., 1., 1.) * mask;
    // Output to screen
    fragColor = vec4(col,1.0);
}