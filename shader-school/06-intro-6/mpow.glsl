mat2 matrixPower(highp mat2 m, int n) {
  
  //Raise the matrix m to nth power

  // For example:
  //
  //  matrixPower(m, 2) = m * m
  //

  mat2 res = mat2(1.);
  int j = n;
  for (int i = 0; i <= 16; i++) {
    res *= m;
    j--;
    if (j <= 0) {
      break;
    }
  }
  return res;  
}

//Do not change this line or the name of the above function
#pragma glslify: export(matrixPower)