void sideLengths(
  highp float hypotenuse, 
  highp float angleInDegrees, 
  out highp float opposite, 
  out highp float adjacent) {
    highp float angle = radians(angleInDegrees);
    opposite = sin(angle) * hypotenuse;
    adjacent = cos(angle) * hypotenuse;
}

//Do not change this line
#pragma glslify: export(sideLengths)