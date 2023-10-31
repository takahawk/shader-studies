float vert_line(vec2 uv, float x, float y1, float y2, float b) {
    float line = smoothstep(x - b, x, uv.x) - smoothstep(x, x + b, uv.x);
    float inBound = step(y1, uv.y) * step(uv.y, y2);
    return line * inBound;
}

float hor_line(vec2 uv, float x1, float x2, float y, float b) {
    return vert_line(vec2(uv.y, uv.x), y, x1, x2, b);
}

vec2 next_section(vec2 uv, vec2 a, float size, float ratio) {
    return vec2(a.x + size * pow(ratio, 2.) - size * pow(ratio, 4.),
                a.y - size + size * pow(ratio, 3.));
}

float spiral_section(vec2 uv, vec2 start, float size, float ratio, float blur) {
    vec2 a = start;
    vec2 b = vec2(a.x, a.y - size);
    vec2 c = vec2(b.x + size * pow(ratio, 2.), b.y);
    vec2 d = vec2(c.x, c.y + size * pow(ratio, 3.));
    vec2 e = vec2(d.x - size * pow(ratio, 4.), d.y);
    float col = vert_line(uv, a.x, b.y, a.y, blur);
    col += hor_line(uv, b.x, c.x, c.y, blur);
    col += vert_line(uv, c.x, c.y, d.y, blur);
    col += hor_line(uv, e.x, d.x, e.y, blur);
    return col;
}


void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = fragCoord/iResolution.xy;
    uv -= 0.5;
    uv /= mod(iTime, 2.7);
    int steps = 16;
    vec2 start = vec2(-0.375, 0.625);
    float col = 0.;
    float size = 1.;
    float ratio = 0.9;
    float blur = 0.01;
    for (int i = 0; i < steps; i++) {
        col += spiral_section(uv, start, size, ratio, blur);
        start = next_section(uv, start, size, ratio);
        size *= pow(ratio, 5.);
        blur *= pow(ratio, 5.);
    }
    // Output to screen
    fragColor = vec4(vec3(col),1.0);
}