highp mat4 scale(highp vec3 p) {
  return mat4(p.x, 0, 0, 0,
              0, p.y, 0, 0, 
              0, 0, p.z, 0,
              0, 0, 0, 1);
}

#pragma glslify: export(scale)