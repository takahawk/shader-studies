precision mediump float;

attribute vec3 position;
uniform mat4 model, view, projection;
uniform vec3 ambient;

void main() {
  vec4 vertex = vec4(position, 1.0);
  gl_Position = projection * view * model * vertex;
}
