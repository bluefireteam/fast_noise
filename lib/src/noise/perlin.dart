import 'package:fast_noise/src/math.dart';

import 'package:fast_noise/src/noise/enums.dart';

class PerlinNoise {
  final int seed, octaves;
  final double frequency, lacunarity, gain;
  final Interp interp;
  final FractalType fractalType;
  final CellularReturnType cellularReturnType;
  final double fractalBounding;

  PerlinNoise(
      {this.seed: 1337,
      this.frequency: .01,
      this.interp: Interp.Quintic,
      this.octaves: 3,
      this.lacunarity: 2.0,
      this.gain: .5,
      this.fractalType: FractalType.FBM,
      this.cellularReturnType: CellularReturnType.CellValue})
      : this.fractalBounding = calculateFractalBounding(gain, octaves);

  double getPerlinFractal3(double x, double y, double z) {
    x *= frequency;
    y *= frequency;
    z *= frequency;

    switch (fractalType) {
      case FractalType.FBM:
        return singlePerlinFractalFBM3(x, y, z);
      case FractalType.Billow:
        return singlePerlinFractalBillow3(x, y, z);
      case FractalType.RigidMulti:
        return singlePerlinFractalRigidMulti3(x, y, z);
    }

    return .0;
  }

  double singlePerlinFractalFBM3(double x, double y, double z) {
    int seed = this.seed;
    double sum = singlePerlin3(seed, x, y, z);
    double amp = 1.0;

    for (int i = 1; i < octaves; i++) {
      x *= lacunarity;
      y *= lacunarity;
      z *= lacunarity;

      amp *= gain;
      sum += singlePerlin3(++seed, x, y, z) * amp;
    }

    return sum * fractalBounding;
  }

  double singlePerlinFractalBillow3(double x, double y, double z) {
    int seed = this.seed;
    double sum = singlePerlin3(seed, x, y, z).abs() * 2.0 - 1.0;
    double amp = 1.0;

    for (int i = 1; i < octaves; i++) {
      x *= lacunarity;
      y *= lacunarity;
      z *= lacunarity;

      amp *= gain;
      sum += (singlePerlin3(++seed, x, y, z).abs() * 2.0 - 1.0) * amp;
    }

    return sum * fractalBounding;
  }

  double singlePerlinFractalRigidMulti3(double x, double y, double z) {
    int seed = this.seed;
    double sum = 1.0 - singlePerlin3(seed, x, y, z).abs();
    double amp = 1.0;

    for (int i = 1; i < octaves; i++) {
      x *= lacunarity;
      y *= lacunarity;
      z *= lacunarity;

      amp *= gain;
      sum -= (1.0 - singlePerlin3(++seed, x, y, z).abs()) * amp;
    }

    return sum;
  }

  double getPerlin3(double x, double y, double z) {
    return singlePerlin3(seed, x * frequency, y * frequency, z * frequency);
  }

  double singlePerlin3(int seed, double x, double y, double z) {
    int x0 = fastFloor(x);
    int y0 = fastFloor(y);
    int z0 = fastFloor(z);
    int x1 = x0 + 1;
    int y1 = y0 + 1;
    int z1 = z0 + 1;

    double xs, ys, zs;
    switch (interp) {
      case Interp.Linear:
        xs = x - x0;
        ys = y - y0;
        zs = z - z0;
        break;
      case Interp.Hermite:
        xs = interpHermiteFunc(x - x0);
        ys = interpHermiteFunc(y - y0);
        zs = interpHermiteFunc(z - z0);
        break;
      case Interp.Quintic:
        xs = interpQuinticFunc(x - x0);
        ys = interpQuinticFunc(y - y0);
        zs = interpQuinticFunc(z - z0);
        break;
    }

    double xd0 = x - x0;
    double yd0 = y - y0;
    double zd0 = z - z0;
    double xd1 = xd0 - 1;
    double yd1 = yd0 - 1;
    double zd1 = zd0 - 1;

    double xf00 = lerp(gradCoord3D(seed, x0, y0, z0, xd0, yd0, zd0),
        gradCoord3D(seed, x1, y0, z0, xd1, yd0, zd0), xs);
    double xf10 = lerp(gradCoord3D(seed, x0, y1, z0, xd0, yd1, zd0),
        gradCoord3D(seed, x1, y1, z0, xd1, yd1, zd0), xs);
    double xf01 = lerp(gradCoord3D(seed, x0, y0, z1, xd0, yd0, zd1),
        gradCoord3D(seed, x1, y0, z1, xd1, yd0, zd1), xs);
    double xf11 = lerp(gradCoord3D(seed, x0, y1, z1, xd0, yd1, zd1),
        gradCoord3D(seed, x1, y1, z1, xd1, yd1, zd1), xs);

    double yf0 = lerp(xf00, xf10, ys);
    double yf1 = lerp(xf01, xf11, ys);

    return lerp(yf0, yf1, zs);
  }

  double getPerlinFractal2(double x, double y) {
    x *= frequency;
    y *= frequency;

    switch (fractalType) {
      case FractalType.FBM:
        return singlePerlinFractalFBM2(x, y);
      case FractalType.Billow:
        return singlePerlinFractalBillow2(x, y);
      case FractalType.RigidMulti:
        return singlePerlinFractalRigidMulti2(x, y);
    }

    return .0;
  }

  double singlePerlinFractalFBM2(double x, double y) {
    int seed = this.seed;
    double sum = singlePerlin2(seed, x, y);
    double amp = 1.0;

    for (int i = 1; i < octaves; i++) {
      x *= lacunarity;
      y *= lacunarity;

      amp *= gain;
      sum += singlePerlin2(++seed, x, y) * amp;
    }

    return sum * fractalBounding;
  }

  double singlePerlinFractalBillow2(double x, double y) {
    int seed = this.seed;
    double sum = singlePerlin2(seed, x, y).abs() * 2.0 - 1.0;
    double amp = 1.0;

    for (int i = 1; i < octaves; i++) {
      x *= lacunarity;
      y *= lacunarity;

      amp *= gain;
      sum += (singlePerlin2(++seed, x, y).abs() * 2.0 - 1.0) * amp;
    }

    return sum * fractalBounding;
  }

  double singlePerlinFractalRigidMulti2(double x, double y) {
    int seed = this.seed;
    double sum = 1.0 - singlePerlin2(seed, x, y).abs();
    double amp = 1.0;

    for (int i = 1; i < octaves; i++) {
      x *= lacunarity;
      y *= lacunarity;

      amp *= gain;
      sum -= (1.0 - singlePerlin2(++seed, x, y).abs()) * amp;
    }

    return sum;
  }

  double getPerlin2(double x, double y) =>
      singlePerlin2(seed, x * frequency, y * frequency);

  double singlePerlin2(int seed, double x, double y) {
    int x0 = fastFloor(x);
    int y0 = fastFloor(y);
    int x1 = x0 + 1;
    int y1 = y0 + 1;

    double xs, ys;
    switch (interp) {
      case Interp.Linear:
        xs = x - x0;
        ys = y - y0;
        break;
      case Interp.Hermite:
        xs = interpHermiteFunc(x - x0);
        ys = interpHermiteFunc(y - y0);
        break;
      case Interp.Quintic:
        xs = interpQuinticFunc(x - x0);
        ys = interpQuinticFunc(y - y0);
        break;
    }

    double xd0 = x - x0;
    double yd0 = y - y0;
    double xd1 = xd0 - 1;
    double yd1 = yd0 - 1;

    double xf0 = lerp(gradCoord2D(seed, x0, y0, xd0, yd0),
        gradCoord2D(seed, x1, y0, xd1, yd0), xs);
    double xf1 = lerp(gradCoord2D(seed, x0, y1, xd0, yd1),
        gradCoord2D(seed, x1, y1, xd1, yd1), xs);

    return lerp(xf0, xf1, ys);
  }
}
