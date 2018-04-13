import 'package:fixnum/fixnum.dart';

import 'package:fast_noise/src/float.dart';

class Vector2f {
  double x, y;

  Vector2f(this.x, this.y);
}

class Vector3f {
  double x, y, z;

  Vector3f(this.x, this.y, this.z);
}

double calculateFractalBounding(double gain, int octaves) {
  double amp = gain, ampFractal = 1.0;

  for (int i = 1; i < octaves; i++) {
    ampFractal += amp;
    amp *= gain;
  }

  return 1.0 / ampFractal;
}

int fastFloor(double f) => f.floor();

int fastRound(double f) => f.round();

double lerp(double a, double b, double t) => a + t * (b - a);

double interpHermiteFunc(double t) => t * t * (3 - 2 * t);

double interpQuinticFunc(double t) => t * t * t * (t * (t * 6 - 15) + 10);

double cubicLerp(double a, double b, double c, double d, double t) {
  final double p = (d - c) - (a - b);
  return t * t * t * p + t * t * ((a - b) - p) + t * (c - a) + b;
}

const int X_PRIME = 1619;
const int Y_PRIME = 31337;
const int Z_PRIME = 6971;
const int W_PRIME = 1013;

int hash2D(int seed, int x, int y) {
  Int32 hash = new Int32(seed);
  hash ^= X_PRIME * x;
  hash ^= Y_PRIME * y;

  hash = hash * hash * hash * 60493;
  hash = (hash >> 13) ^ hash;

  return hash.toInt();
}

int hash3D(int seed, int x, int y, int z) {
  Int32 hash = new Int32(seed);
  hash ^= X_PRIME * x;
  hash ^= Y_PRIME * y;
  hash ^= Z_PRIME * z;

  hash = hash * hash * hash * 60493;
  hash = (hash >> 13) ^ hash;

  return hash.toInt();
}

double valCoord2D(int seed, int x, int y) {
  Int32 n = new Int32(seed);
  n ^= X_PRIME * x;
  n ^= Y_PRIME * y;

  return (n * n * n * 60493).toDouble() / 2147483648;
}

double valCoord3D(int seed, int x, int y, int z) {
  Int32 n = new Int32(seed);
  n ^= X_PRIME * x;
  n ^= Y_PRIME * y;
  n ^= Z_PRIME * z;

  return (n * n * n * 60493).toDouble() / 2147483648;
}

double valCoord4D(int seed, int x, int y, int z, int w) {
  Int32 n = new Int32(seed);
  n ^= X_PRIME * x;
  n ^= Y_PRIME * y;
  n ^= Z_PRIME * z;
  n ^= W_PRIME * w;

  return (n * n * n * 60493).toDouble() / 2147483648;
}

double gradCoord2D(int seed, int x, int y, double xd, double yd) {
  Int32 hash = new Int32(seed);
  hash ^= X_PRIME * x;
  hash ^= Y_PRIME * y;

  hash = hash * hash * hash * 60493;
  hash = (hash >> 13) ^ hash;

  Float2 g = GRAD_2D[hash.toInt() & 7];

  return xd * g.x + yd * g.y;
}

double gradCoord3D(
    int seed, int x, int y, int z, double xd, double yd, double zd) {
  Int32 hash = new Int32(seed);
  hash ^= X_PRIME * x;
  hash ^= Y_PRIME * y;
  hash ^= Z_PRIME * z;

  hash = hash * hash * hash * 60493;
  hash = (hash >> 13) ^ hash;

  Float3 g = GRAD_3D[hash.toInt() & 15];

  return xd * g.x + yd * g.y + zd * g.z;
}

double gradCoord4D(int seed, int x, int y, int z, int w, double xd, double yd,
    double zd, double wd) {
  Int32 hash = new Int32(seed);
  hash ^= X_PRIME * x;
  hash ^= Y_PRIME * y;
  hash ^= Z_PRIME * z;
  hash ^= W_PRIME * w;

  hash = hash * hash * hash * 60493;
  hash = (hash >> 13) ^ hash;

  hash &= 31;
  double a = yd, b = zd, c = wd;
  switch (hash.toInt() >> 3) {
    case 1:
      a = wd;
      b = xd;
      c = yd;
      break; // W,X,Y
    case 2:
      a = zd;
      b = wd;
      c = xd;
      break; // Z,W,X
    case 3:
      a = yd;
      b = zd;
      c = wd;
      break; // Y,Z,W
  }
  return ((hash & 4).toInt() == 0 ? -a : a) +
      ((hash & 2).toInt() == 0 ? -b : b) +
      ((hash & 1).toInt() == 0 ? -c : c);
}
