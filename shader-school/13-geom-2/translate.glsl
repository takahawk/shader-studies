highp mat4 translate(highp vec3 p) {
  return mat4(1, 0, 0, 0,
              0, 1, 0, 0, 
              0, 0, 1, 0,
              -p.x, -p.y, -p.z, 1);
}

//Do not remove this line
#pragma glslify: export(translate)