float vert_line(vec2 uv, float x, float y1, float y2, float b) {
    float line = smoothstep(x - b, x, uv.x) - smoothstep(x, x + b, uv.x);
    float inBound = step(y1, uv.y) * step(uv.y, y2);
    return line * inBound;
}

float hor_line(vec2 uv, float x1, float x2, float y, float b) {
    return vert_line(vec2(uv.y, uv.x), y, x1, x2, b);
}

vec2 next_section(vec2 uv, vec2 a, float size, float ratio) {
    return vec2(a.x - size + size * pow(ratio, 2.),
                a.y + pow(ratio, 1.) * size - pow(ratio, 3.) * size);
}

float spiral_section(vec2 uv, vec2 start, float size, float ratio, float blur) {
    vec2 a = start;
    vec2 b = vec2(a.x - size, a.y);
    vec2 c = vec2(b.x, b.y + pow(ratio, 1.) * size);
    vec2 d = vec2(c.x + pow(ratio, 2.) * size, c.y);
    vec2 e = vec2(d.x, d.y - pow(ratio, 3.) * size);
    float col = hor_line(uv, b.x, a.x, a.y, blur);
    col += vert_line(uv, b.x, b.y, c.y, blur);
    col += hor_line(uv, c.x, d.x, d.y, blur);
    col += vert_line(uv, d.x, e.y, d.y, blur);
    return col;
}

float spiral(vec2 uv, float scale) {
    uv -= 0.5;
    
    uv /= scale;
    int steps = 32;
    vec2 start = vec2(0., 0.);
    float col = 0.;
    float size = 0.001;
    float ratio = 1.05;
    float blur = 0.005 / scale;
    for (int i = 0; i < steps; i++) {
        col += spiral_section(uv, start, size, ratio, blur);
        start = next_section(uv, start, size, ratio);
        size *= pow(ratio, 5.);
        // blur *= pow(ratio, 5.);
    }
    return col;
}


void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = fragCoord/iResolution.xy;
    float period = 3.2;
    float scale = 1. +  fract(iTime) * period;
    float col = spiral(uv, scale);
    fragColor = vec4(col * vec3(0., 1., 0.),1.0);
}   