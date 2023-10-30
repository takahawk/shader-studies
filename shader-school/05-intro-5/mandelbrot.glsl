vec2 calculateMandelbrot(vec2 z, vec2 c) {
  return vec2(z.x*z.x - z.y*z.y, 2.0*z.x * z.y) + c;
}

bool mandelbrotConverges(vec2 z) {
  return length(z) < 2.;
}

bool mandelbrot(highp vec2 c) {
  vec2 z = vec2(0.,0.);

  for (int i = 0; i < 101; i++) {
    z = calculateMandelbrot(z, c); 
  }
  if (mandelbrotConverges(z))
      return true;

  return false;
}


//Do not change this line or the name of the above function
#pragma glslify: export(mandelbrot)
