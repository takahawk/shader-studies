vec4 red     = vec4(1., 0., 0., 1.);
vec4 orange  = vec4(1., 102. / 255., 0., 1.);
vec4 yellow  = vec4(1., 1., 0., 1.);
vec4 green   = vec4(0., 1., 0., 1.);
vec4 blue    = vec4(0., 0., 1., 1.);
vec4 indigo  = vec4(float(0x4b) / float(0xFF), 0., float(0x82) / float(0xFF), 1.);
vec4 violet  = vec4(float(0xee) / float(0xff), 
                    float(0x82) / float(0xFF), 
                    float(0xee) / float(0xff), 1.);

vec4 digitToColor(int digit) {
    switch (digit) {
    case 0: return red;
    case 1: return orange;
    case 2: return yellow;
    case 3: return green;
    case 4: return blue;
    case 5: return indigo;
    case 6: return violet;
    }
    
    return vec4(0.);
}

vec4 digitToColor(float digit) {
    return digitToColor(int(floor(digit)));
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = fragCoord/iResolution.xy;
    
    // 7 digits
    int position = int(floor((1. - uv.x) / (1. / 7.)));
    float digit = iTime;
    
    for (int i = 0; i < position; i++) {
        digit /= 7.;
    }
    digit = mod(digit, 7.);

    vec4 col = digitToColor(digit);

    // Output to screen
    fragColor = col;
}