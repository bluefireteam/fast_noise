import 'package:fast_noise/src/utils.dart';

import 'package:fast_noise/src/noise/enums.dart';

class ValueNoise {
  final int seed, octaves;
  final double frequency, lacunarity, gain;
  final Interp interp;
  final FractalType fractalType;
  final CellularReturnType cellularReturnType;
  final double fractalBounding;

  ValueNoise(
      {this.seed: 1337,
      this.frequency: .01,
      this.interp: Interp.Quintic,
      this.octaves: 3,
      this.lacunarity: 2.0,
      this.gain: .5,
      this.fractalType: FractalType.FBM,
      this.cellularReturnType: CellularReturnType.CellValue})
      : this.fractalBounding = calculateFractalBounding(gain, octaves);

  double getValueFractal3(double x, double y, double z) {
    x *= frequency;
    y *= frequency;
    z *= frequency;

    switch (fractalType) {
      case FractalType.FBM:
        return singleValueFractalFBM3(x, y, z);
      case FractalType.Billow:
        return singleValueFractalBillow3(x, y, z);
      case FractalType.RigidMulti:
        return singleValueFractalRigidMulti3(x, y, z);
    }
    return .0;
  }

  double singleValueFractalFBM3(double x, double y, double z) {
    int seed = this.seed;
    double sum = singleValue3(seed, x, y, z);
    double amp = 1.0;

    for (int i = 1; i < octaves; i++) {
      x *= lacunarity;
      y *= lacunarity;
      z *= lacunarity;

      amp *= gain;
      sum += singleValue3(++seed, x, y, z) * amp;
    }

    return sum * fractalBounding;
  }

  double singleValueFractalBillow3(double x, double y, double z) {
    int seed = this.seed;
    double sum = singleValue3(seed, x, y, z).abs() * 2.0 - 1.0;
    double amp = 1.0;

    for (int i = 1; i < octaves; i++) {
      x *= lacunarity;
      y *= lacunarity;
      z *= lacunarity;

      amp *= gain;
      sum += (singleValue3(++seed, x, y, z).abs() * 2.0 - 1.0) * amp;
    }

    return sum * fractalBounding;
  }

  double singleValueFractalRigidMulti3(double x, double y, double z) {
    int seed = this.seed;
    double sum = 1.0 - singleValue3(seed, x, y, z).abs();
    double amp = 1.0;

    for (int i = 1; i < octaves; i++) {
      x *= lacunarity;
      y *= lacunarity;
      z *= lacunarity;

      amp *= gain;
      sum -= (1.0 - singleValue3(++seed, x, y, z).abs()) * amp;
    }

    return sum;
  }

  double getValue3(double x, double y, double z) {
    return singleValue3(seed, x * frequency, y * frequency, z * frequency);
  }

  double singleValue3(int seed, double x, double y, double z) {
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

    double xf00 =
        lerp(valCoord3D(seed, x0, y0, z0), valCoord3D(seed, x1, y0, z0), xs);
    double xf10 =
        lerp(valCoord3D(seed, x0, y1, z0), valCoord3D(seed, x1, y1, z0), xs);
    double xf01 =
        lerp(valCoord3D(seed, x0, y0, z1), valCoord3D(seed, x1, y0, z1), xs);
    double xf11 =
        lerp(valCoord3D(seed, x0, y1, z1), valCoord3D(seed, x1, y1, z1), xs);

    double yf0 = lerp(xf00, xf10, ys);
    double yf1 = lerp(xf01, xf11, ys);

    return lerp(yf0, yf1, zs);
  }

  double getValueFractal2(double x, double y) {
    x *= frequency;
    y *= frequency;

    switch (fractalType) {
      case FractalType.FBM:
        return singleValueFractalFBM2(x, y);
      case FractalType.Billow:
        return singleValueFractalBillow2(x, y);
      case FractalType.RigidMulti:
        return singleValueFractalRigidMulti2(x, y);
    }
    return .0;
  }

  double singleValueFractalFBM2(double x, double y) {
    int seed = this.seed;
    double sum = singleValue2(seed, x, y);
    double amp = 1.0;

    for (int i = 1; i < octaves; i++) {
      x *= lacunarity;
      y *= lacunarity;

      amp *= gain;
      sum += singleValue2(++seed, x, y) * amp;
    }

    return sum * fractalBounding;
  }

  double singleValueFractalBillow2(double x, double y) {
    int seed = this.seed;
    double sum = singleValue2(seed, x, y).abs() * 2.0 - 1.0;
    double amp = 1.0;

    for (int i = 1; i < octaves; i++) {
      x *= lacunarity;
      y *= lacunarity;
      amp *= gain;
      sum += (singleValue2(++seed, x, y).abs() * 2.0 - 1.0) * amp;
    }

    return sum * fractalBounding;
  }

  double singleValueFractalRigidMulti2(double x, double y) {
    int seed = this.seed;
    double sum = 1.0 - singleValue2(seed, x, y).abs();
    double amp = 1.0;

    for (int i = 1; i < octaves; i++) {
      x *= lacunarity;
      y *= lacunarity;

      amp *= gain;
      sum -= (1.0 - singleValue2(++seed, x, y).abs()) * amp;
    }

    return sum;
  }

  double getValue2(double x, double y) =>
      singleValue2(seed, x * frequency, y * frequency);

  double singleValue2(int seed, double x, double y) {
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

    double xf0 = lerp(valCoord2D(seed, x0, y0), valCoord2D(seed, x1, y0), xs);
    double xf1 = lerp(valCoord2D(seed, x0, y1), valCoord2D(seed, x1, y1), xs);

    return lerp(xf0, xf1, ys);
  }
}
