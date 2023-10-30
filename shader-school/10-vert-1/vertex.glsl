precision highp float;

uniform float theta;

attribute vec2 position;

void main() {
  float x = position.x * cos(theta) - position.y * sin(theta);
  float y = position.x * sin(theta) + position.y * cos(theta);
  gl_Position = vec4(x, y, 0, 1.0);
}
