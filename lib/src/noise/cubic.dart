import 'package:fast_noise/src/utils.dart';

import 'package:fast_noise/src/noise/enums.dart';

class CubicNoise {
  final int seed, octaves;
  final double frequency, lacunarity, gain;
  final Interp interp;
  final FractalType fractalType;
  final CellularReturnType cellularReturnType;
  final double fractalBounding;

  CubicNoise(
      {this.seed = 1337,
      this.frequency = .01,
      this.interp = Interp.Quintic,
      this.octaves = 3,
      this.lacunarity = 2.0,
      this.gain = .5,
      this.fractalType = FractalType.FBM,
      this.cellularReturnType = CellularReturnType.CellValue})
      : fractalBounding = calculateFractalBounding(gain, octaves);

  double getCubicFractal3(double x, double y, double z) {
    x *= frequency;
    y *= frequency;
    z *= frequency;

    switch (fractalType) {
      case FractalType.FBM:
        return singleCubicFractalFBM3(x, y, z);
      case FractalType.Billow:
        return singleCubicFractalBillow3(x, y, z);
      case FractalType.RigidMulti:
        return singleCubicFractalRigidMulti3(x, y, z);
    }

    return .0;
  }

  double singleCubicFractalFBM3(double x, double y, double z) {
    var seed = this.seed, i = 0;
    var sum = singleCubic3(seed, x, y, z), amp = 1.0;

    while (++i < octaves) {
      x *= lacunarity;
      y *= lacunarity;
      z *= lacunarity;

      amp *= gain;
      sum += singleCubic3(++seed, x, y, z) * amp;
    }

    return sum * fractalBounding;
  }

  double singleCubicFractalBillow3(double x, double y, double z) {
    var seed = this.seed, i = 0;
    var sum = singleCubic3(seed, x, y, z).abs() * 2 - 1, amp = 1.0;

    while (++i < octaves) {
      x *= lacunarity;
      y *= lacunarity;
      z *= lacunarity;

      amp *= gain;
      sum += (singleCubic3(++seed, x, y, z).abs() * 2.0 - 1.0) * amp;
    }

    return sum * fractalBounding;
  }

  double singleCubicFractalRigidMulti3(double x, double y, double z) {
    var seed = this.seed, i = 0;
    var sum = 1.0 - singleCubic3(seed, x, y, z).abs(), amp = 1.0;

    while (++i < octaves) {
      x *= lacunarity;
      y *= lacunarity;
      z *= lacunarity;

      amp *= gain;
      sum -= (1.0 - singleCubic3(++seed, x, y, z).abs()) * amp;
    }

    return sum;
  }

  double getCubic3(double x, double y, double z) =>
      singleCubic3(seed, x * frequency, y * frequency, z * frequency);

  static const double CUBIC_3D_BOUNDING = 1.0 / (1.5 * 1.5 * 1.5);

  double singleCubic3(int seed, double x, double y, double z) {
    final x1 = fastFloor(x), y1 = fastFloor(y), z1 = fastFloor(z);
    final x0 = x1 - 1,
        y0 = y1 - 1,
        z0 = z1 - 1,
        x2 = x1 + 1,
        y2 = y1 + 1,
        z2 = z1 + 1,
        x3 = x1 + 2,
        y3 = y1 + 2,
        z3 = z1 + 2;
    final xs = x - x1, ys = y - y1, zs = z - z1;

    return cubicLerp(
            cubicLerp(
                cubicLerp(valCoord3D(seed, x0, y0, z0), valCoord3D(seed, x1, y0, z0),
                    valCoord3D(seed, x2, y0, z0), valCoord3D(seed, x3, y0, z0), xs),
                cubicLerp(valCoord3D(seed, x0, y1, z0), valCoord3D(seed, x1, y1, z0),
                    valCoord3D(seed, x2, y1, z0), valCoord3D(seed, x3, y1, z0), xs),
                cubicLerp(valCoord3D(seed, x0, y2, z0), valCoord3D(seed, x1, y2, z0),
                    valCoord3D(seed, x2, y2, z0), valCoord3D(seed, x3, y2, z0), xs),
                cubicLerp(valCoord3D(seed, x0, y3, z0), valCoord3D(seed, x1, y3, z0),
                    valCoord3D(seed, x2, y3, z0), valCoord3D(seed, x3, y3, z0), xs),
                ys),
            cubicLerp(
                cubicLerp(valCoord3D(seed, x0, y0, z1), valCoord3D(seed, x1, y0, z1),
                    valCoord3D(seed, x2, y0, z1), valCoord3D(seed, x3, y0, z1), xs),
                cubicLerp(valCoord3D(seed, x0, y1, z1), valCoord3D(seed, x1, y1, z1),
                    valCoord3D(seed, x2, y1, z1), valCoord3D(seed, x3, y1, z1), xs),
                cubicLerp(valCoord3D(seed, x0, y2, z1), valCoord3D(seed, x1, y2, z1),
                    valCoord3D(seed, x2, y2, z1), valCoord3D(seed, x3, y2, z1), xs),
                cubicLerp(valCoord3D(seed, x0, y3, z1), valCoord3D(seed, x1, y3, z1),
                    valCoord3D(seed, x2, y3, z1), valCoord3D(seed, x3, y3, z1), xs),
                ys),
            cubicLerp(
                cubicLerp(valCoord3D(seed, x0, y0, z2), valCoord3D(seed, x1, y0, z2),
                    valCoord3D(seed, x2, y0, z2), valCoord3D(seed, x3, y0, z2), xs),
                cubicLerp(valCoord3D(seed, x0, y1, z2), valCoord3D(seed, x1, y1, z2),
                    valCoord3D(seed, x2, y1, z2), valCoord3D(seed, x3, y1, z2), xs),
                cubicLerp(valCoord3D(seed, x0, y2, z2), valCoord3D(seed, x1, y2, z2),
                    valCoord3D(seed, x2, y2, z2), valCoord3D(seed, x3, y2, z2), xs),
                cubicLerp(valCoord3D(seed, x0, y3, z2), valCoord3D(seed, x1, y3, z2),
                    valCoord3D(seed, x2, y3, z2), valCoord3D(seed, x3, y3, z2), xs),
                ys),
            cubicLerp(
                cubicLerp(valCoord3D(seed, x0, y0, z3), valCoord3D(seed, x1, y0, z3),
                    valCoord3D(seed, x2, y0, z3), valCoord3D(seed, x3, y0, z3), xs),
                cubicLerp(valCoord3D(seed, x0, y1, z3), valCoord3D(seed, x1, y1, z3),
                    valCoord3D(seed, x2, y1, z3), valCoord3D(seed, x3, y1, z3), xs),
                cubicLerp(valCoord3D(seed, x0, y2, z3), valCoord3D(seed, x1, y2, z3),
                    valCoord3D(seed, x2, y2, z3), valCoord3D(seed, x3, y2, z3), xs),
                cubicLerp(valCoord3D(seed, x0, y3, z3), valCoord3D(seed, x1, y3, z3),
                    valCoord3D(seed, x2, y3, z3), valCoord3D(seed, x3, y3, z3), xs),
                ys),
            zs) *
        CUBIC_3D_BOUNDING;
  }

  double getCubicFractal2(double x, double y) {
    x *= frequency;
    y *= frequency;

    switch (fractalType) {
      case FractalType.FBM:
        return singleCubicFractalFBM2(x, y);
      case FractalType.Billow:
        return singleCubicFractalBillow2(x, y);
      case FractalType.RigidMulti:
        return singleCubicFractalRigidMulti2(x, y);
    }

    return .0;
  }

  double singleCubicFractalFBM2(double x, double y) {
    var seed = this.seed, i = 0;
    var sum = singleCubic2(seed, x, y), amp = 1.0;

    while (++i < octaves) {
      x *= lacunarity;
      y *= lacunarity;

      amp *= gain;
      sum += singleCubic2(++seed, x, y) * amp;
    }

    return sum * fractalBounding;
  }

  double singleCubicFractalBillow2(double x, double y) {
    var seed = this.seed, i = 0;
    var sum = singleCubic2(seed, x, y).abs() * 2.0 - 1.0, amp = 1.0;

    while (++i < octaves) {
      x *= lacunarity;
      y *= lacunarity;

      amp *= gain;
      sum += (singleCubic2(++seed, x, y).abs() * 2.0 - 1.0) * amp;
    }

    return sum * fractalBounding;
  }

  double singleCubicFractalRigidMulti2(double x, double y) {
    var seed = this.seed, i = 0;
    var sum = 1 - singleCubic2(seed, x, y).abs(), amp = 1.0;

    while (++i < octaves) {
      x *= lacunarity;
      y *= lacunarity;

      amp *= gain;
      sum -= (1.0 - singleCubic2(++seed, x, y).abs()) * amp;
    }

    return sum;
  }

  double getCubic2(double x, double y) {
    x *= frequency;
    y *= frequency;

    return singleCubic2(0, x, y);
  }

  static const double CUBIC_2D_BOUNDING = 1.0 / (1.5 * 1.5);

  double singleCubic2(int seed, double x, double y) {
    final x1 = fastFloor(x), y1 = fastFloor(y);
    final x0 = x1 - 1, y0 = y1 - 1, x2 = x1 + 1, y2 = y1 + 1, x3 = x1 + 2, y3 = y1 + 2;
    final xs = x - x1, ys = y - y1;

    return cubicLerp(
            cubicLerp(valCoord2D(seed, x0, y0), valCoord2D(seed, x1, y0),
                valCoord2D(seed, x2, y0), valCoord2D(seed, x3, y0), xs),
            cubicLerp(valCoord2D(seed, x0, y1), valCoord2D(seed, x1, y1),
                valCoord2D(seed, x2, y1), valCoord2D(seed, x3, y1), xs),
            cubicLerp(valCoord2D(seed, x0, y2), valCoord2D(seed, x1, y2),
                valCoord2D(seed, x2, y2), valCoord2D(seed, x3, y2), xs),
            cubicLerp(valCoord2D(seed, x0, y3), valCoord2D(seed, x1, y3),
                valCoord2D(seed, x2, y3), valCoord2D(seed, x3, y3), xs),
            ys) *
        CUBIC_2D_BOUNDING;
  }
}
