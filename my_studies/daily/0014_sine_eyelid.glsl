#define PI  3.14159265359 

float ping_pong(float t, float r) {
    t = mod(t, r * 2.);
    if (t > r) {
        return 2. * r - t;
    }
    
    return t;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = fragCoord/iResolution.xy;
    uv.x *= iResolution.x / iResolution.y;
    uv.x -= 0.1;
    uv.y -= 0.5;
    uv *= 2.;
    
    // uv.x += iTime;
    if (uv.x > 0. && uv.x < PI) {

        float mask = 0.;
        float mod_step = ping_pong(iTime / 25., 0.05);
        int steps = 128;

        float modifier = 1.;
        for (int i = 0; i < steps; i++) {
            mask += 1. - step(0.01, abs(uv.y - modifier * sin(uv.x)));
            mask += 1. - step(0.01, abs(uv.y + modifier * sin(uv.x)));
            modifier = modifier * (1. - mod_step);
        }

        // Time varying pixel color
        vec3 col = 0.5 + 0.5*cos(iTime+uv.xyx+vec3(0,2,4));

        // Output to screen
        fragColor = vec4(mask * col,1.0);
    } else {
        fragColor = vec4(0., 0., 0., 1.);
    }
}