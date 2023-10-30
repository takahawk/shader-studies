highp mat4 rotation(highp vec3 n, highp float theta) {

  // p * cos(theta) + cross(n, p) * sin(theta) + n * dot(p, n) * (1.0 - cos(theta))
  // p.x = p.x * cos(theta) + (n.y * p.z - n.z * p.y) * sin(theta) + n.x * (p.x * n.x + p.y * n.y + p.z * n.z) * (1.0 - cos(theta))
  // p.y = p.y * cos(theta) + (n.z * p.x - n.x * p.z) * sin(theta) + n.y * (p.x * n.x + p.y * n.y + p.z * n.z) * (1.0 - cos(theta))
  // p.z = p.z * cos(theta) + (n.x * p.y - n.y * p.x) * sin(theta) + n.z * (p.x * n.x + p.y * n.y + p.z * n.z) * (1.0 - cos(theta))
  mat4 a = mat4(1.0);
  a[0][0] = cos(theta) + n.x*n.x * (1.0 - cos(theta));
  a[1][0] = -n.z * sin(theta) + n.x * n.y * (1.0 - cos(theta));
  a[2][0] = n.y * sin(theta) + n.x * n.z * (1.0 - cos(theta));

  a[0][1] = n.z * sin(theta) + n.y * n.x * (1.0 - cos(theta));
  a[1][1] = cos(theta) + n.y*n.y * (1.0 - cos(theta));
  a[2][1] = -n.x * sin(theta) + n.y * n.z * (1.0 - cos(theta));

  a[0][2] = -n.y * sin(theta) + n.z * n.x * (1.0 - cos(theta));
  a[1][2] = n.x * sin(theta) + n.z * n.y * (1.0 - cos(theta));
  a[2][2] = cos(theta) + n.z*n.z * (1.0 - cos(theta));
  return a;
}

#pragma glslify: export(rotation)