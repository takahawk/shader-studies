#define PI 3.1415926538

float rand(vec2 co){
    return fract(sin(dot(co, vec2(12.9898, 78.233))) * 43758.5453);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv0 = fragCoord/iResolution.xy;
    vec2 uv = uv0 - 0.5;
    uv.x *= iResolution.x/iResolution.y;
    
    float mask = length(uv);
    mask = smoothstep(0.05, 0., abs(mask - 0.5));
    
    float delete_mask = step(0.5, length(uv));
    
    float th = PI / 6. + 50. * log(iTime);
    uv.x = uv.x * cos(th) - uv.y * sin(th);
    uv.y = uv.y * cos(th) + uv.x * sin(th);
    float line = smoothstep(0.02, 0., abs(uv.x));
    mask += line;
    
    float line2 = smoothstep(0.02, 0., abs(uv.y));
    mask -= line2;
    
    float line3 = smoothstep(0.02, 0., abs(sin(uv.x) - uv.y));
    mask += line3;
    
    vec3 col = mask * vec3(189. / 255., 0., 255. / 255.) + 
        line * vec3(0., 255. / 255., 159. / 255.) +
        line2 * vec3(255., 144./255., 31./255.) +
        line3 * vec3(137./255., 211./255., 25./255.);
    col -= delete_mask;
    
    //float blend_mask = step(-15000000., length(uv0)) * rand(vec2(iTime));
    //col *= blend_mask;
    fragColor = vec4(col,1.0);
}