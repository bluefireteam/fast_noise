import 'package:fast_noise/fast_noise.dart';
import 'package:fixnum/fixnum.dart';

@pragma('vm:prefer-inline')
double calculateFractalBounding(int octaves, double gain) {
  var amp = gain;
  var ampFractal = 1.0;

  for (var i = 1; i < octaves; i++) {
    ampFractal += amp;
    amp *= gain;
  }

  return 1.0 / ampFractal;
}

const int _xPrime = 1619;
const int _yPrime = 31337;
const int _zPrime = 6971;
const int _wPrime = 1013;

@pragma('vm:prefer-inline')
int hash2D(int seed, int x, int y) {
  IntX hash = Int32(seed);
  hash ^= _xPrime * x;
  hash ^= _yPrime * y;

  hash = hash * hash * hash * 60493;
  hash = (hash >> 13) ^ hash;

  return hash.toInt();
}

@pragma('vm:prefer-inline')
int hash3D(int seed, int x, int y, int z) {
  IntX hash = Int32(seed);
  hash ^= _xPrime * x;
  hash ^= _yPrime * y;
  hash ^= _zPrime * z;

  hash = hash * hash * hash * 60493;
  hash = (hash >> 13) ^ hash;

  return hash.toInt();
}

@pragma('vm:prefer-inline')
double valCoord2D(int seed, int x, int y) {
  var n = Int32(seed);
  n ^= _xPrime * x;
  n ^= _yPrime * y;

  return (n * n * n * 60493).toDouble() / 2147483648;
}

@pragma('vm:prefer-inline')
double valCoord3D(int seed, int x, int y, int z) {
  var n = Int32(seed);
  n ^= _xPrime * x;
  n ^= _yPrime * y;
  n ^= _zPrime * z;

  return (n * n * n * 60493).toDouble() / 2147483648;
}

@pragma('vm:prefer-inline')
double valCoord4D(int seed, int x, int y, int z, int w) {
  var n = Int32(seed);
  n ^= _xPrime * x;
  n ^= _yPrime * y;
  n ^= _zPrime * z;
  n ^= _wPrime * w;

  return (n * n * n * 60493).toDouble() / 2147483648;
}

@pragma('vm:prefer-inline')
double gradCoord2D(int seed, int x, int y, double xd, double yd) {
  IntX hash = Int32(seed);
  hash ^= _xPrime * x;
  hash ^= _yPrime * y;

  hash = hash * hash * hash * 60493;
  hash = (hash >> 13) ^ hash;

  final g = gradient2d[hash.toInt() & 7];

  return xd * g.x + yd * g.y;
}

@pragma('vm:prefer-inline')
double gradCoord3D(
  int seed,
  int x,
  int y,
  int z,
  double xd,
  double yd,
  double zd,
) {
  IntX hash = Int32(seed);
  hash ^= _xPrime * x;
  hash ^= _yPrime * y;
  hash ^= _zPrime * z;

  hash = hash * hash * hash * 60493;
  hash = (hash >> 13) ^ hash;

  final g = gradient3d[hash.toInt() & 15];

  return xd * g.x + yd * g.y + zd * g.z;
}

@pragma('vm:prefer-inline')
double gradCoord4D(
  int seed,
  int x,
  int y,
  int z,
  int w,
  double xd,
  double yd,
  double zd,
  double wd,
) {
  IntX hash = Int32(seed);
  hash ^= _xPrime * x;
  hash ^= _yPrime * y;
  hash ^= _zPrime * z;
  hash ^= _wPrime * w;

  hash = hash * hash * hash * 60493;
  hash = (hash >> 13) ^ hash;

  hash &= 31;
  var a = yd;
  var b = zd;
  var c = wd;
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

extension DoubleExtension on double {
  @pragma('vm:prefer-inline')
  double lerp(double a, double b) => a + this * (b - a);

  @pragma('vm:prefer-inline')
  double get interpHermiteFunc => this * this * (3 - 2 * this);

  @pragma('vm:prefer-inline')
  double get interpQuinticFunc =>
      this * this * this * (this * (this * 6 - 15) + 10);

  @pragma('vm:prefer-inline')
  double cubicLerp(double a, double b, double c, double d) {
    final p = (d - c) - (a - b);

    return this * this * this * p +
        this * this * ((a - b) - p) +
        this * (c - a) +
        b;
  }
}
