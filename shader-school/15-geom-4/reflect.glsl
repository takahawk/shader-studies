highp mat4 reflection(highp vec3 n) {

  // p - 2.0 * dot(n, p) * n / dot(n, n) =
  // p - 2.0 * (n.x * p.x + n.y * p.y + n.z * p.z) * n / (n.x * n.x + n.y * n.y + n.z * n.z) =
  // p.x = p.x - 2.0 * (n.x * p.x + n.y * p.y + n.z * p.z) * n.x / (n.x * n.x + n.y * n.y + n.z * n.z)
  float nn = dot(n, n);
  return mat4(nn - 2.*n.x*n.x, -2.*n.x*n.y,     -2.*n.x*n.z, 0,
              -2.*n.y*n.x,     nn - 2.*n.y*n.y, -2.*n.y*n.z, 0, 
              -2.*n.z*n.x,     -2.*n.z*n.y,     nn - 2.*n.z*n.z, 0,
              0, 0, 0, nn);
}

#pragma glslify: export(reflection)