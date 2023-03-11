import 'package:fast_noise/fast_noise.dart';

class CubicNoise implements Noise2And3 {
  final int seed;
  final double frequency;
  final Interp interp;

  CubicNoise({
    this.seed = 1337,
    this.frequency = .01,
    this.interp = Interp.Quintic,
  });

  @override
  double getNoise3(double x, double y, double z) =>
      singleCubic3(seed, x * frequency, y * frequency, z * frequency);

  static const double CUBIC_3D_BOUNDING = 1.0 / (1.5 * 1.5 * 1.5);

  double singleCubic3(int seed, double x, double y, double z) {
    final x1 = x.floor(), y1 = y.floor(), z1 = z.floor();
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

    return zs.cubicLerp(
          ys.cubicLerp(
            xs.cubicLerp(
              valCoord3D(seed, x0, y0, z0),
              valCoord3D(seed, x1, y0, z0),
              valCoord3D(seed, x2, y0, z0),
              valCoord3D(seed, x3, y0, z0),
            ),
            xs.cubicLerp(
              valCoord3D(seed, x0, y1, z0),
              valCoord3D(seed, x1, y1, z0),
              valCoord3D(seed, x2, y1, z0),
              valCoord3D(seed, x3, y1, z0),
            ),
            xs.cubicLerp(
              valCoord3D(seed, x0, y2, z0),
              valCoord3D(seed, x1, y2, z0),
              valCoord3D(seed, x2, y2, z0),
              valCoord3D(seed, x3, y2, z0),
            ),
            xs.cubicLerp(
              valCoord3D(seed, x0, y3, z0),
              valCoord3D(seed, x1, y3, z0),
              valCoord3D(seed, x2, y3, z0),
              valCoord3D(seed, x3, y3, z0),
            ),
          ),
          ys.cubicLerp(
            xs.cubicLerp(
              valCoord3D(seed, x0, y0, z1),
              valCoord3D(seed, x1, y0, z1),
              valCoord3D(seed, x2, y0, z1),
              valCoord3D(seed, x3, y0, z1),
            ),
            xs.cubicLerp(
              valCoord3D(seed, x0, y1, z1),
              valCoord3D(seed, x1, y1, z1),
              valCoord3D(seed, x2, y1, z1),
              valCoord3D(seed, x3, y1, z1),
            ),
            xs.cubicLerp(
              valCoord3D(seed, x0, y2, z1),
              valCoord3D(seed, x1, y2, z1),
              valCoord3D(seed, x2, y2, z1),
              valCoord3D(seed, x3, y2, z1),
            ),
            xs.cubicLerp(
              valCoord3D(seed, x0, y3, z1),
              valCoord3D(seed, x1, y3, z1),
              valCoord3D(seed, x2, y3, z1),
              valCoord3D(seed, x3, y3, z1),
            ),
          ),
          ys.cubicLerp(
            xs.cubicLerp(
              valCoord3D(seed, x0, y0, z2),
              valCoord3D(seed, x1, y0, z2),
              valCoord3D(seed, x2, y0, z2),
              valCoord3D(seed, x3, y0, z2),
            ),
            xs.cubicLerp(
              valCoord3D(seed, x0, y1, z2),
              valCoord3D(seed, x1, y1, z2),
              valCoord3D(seed, x2, y1, z2),
              valCoord3D(seed, x3, y1, z2),
            ),
            xs.cubicLerp(
              valCoord3D(seed, x0, y2, z2),
              valCoord3D(seed, x1, y2, z2),
              valCoord3D(seed, x2, y2, z2),
              valCoord3D(seed, x3, y2, z2),
            ),
            xs.cubicLerp(
              valCoord3D(seed, x0, y3, z2),
              valCoord3D(seed, x1, y3, z2),
              valCoord3D(seed, x2, y3, z2),
              valCoord3D(seed, x3, y3, z2),
            ),
          ),
          ys.cubicLerp(
            xs.cubicLerp(
              valCoord3D(seed, x0, y0, z3),
              valCoord3D(seed, x1, y0, z3),
              valCoord3D(seed, x2, y0, z3),
              valCoord3D(seed, x3, y0, z3),
            ),
            xs.cubicLerp(
              valCoord3D(seed, x0, y1, z3),
              valCoord3D(seed, x1, y1, z3),
              valCoord3D(seed, x2, y1, z3),
              valCoord3D(seed, x3, y1, z3),
            ),
            xs.cubicLerp(
              valCoord3D(seed, x0, y2, z3),
              valCoord3D(seed, x1, y2, z3),
              valCoord3D(seed, x2, y2, z3),
              valCoord3D(seed, x3, y2, z3),
            ),
            xs.cubicLerp(
              valCoord3D(seed, x0, y3, z3),
              valCoord3D(seed, x1, y3, z3),
              valCoord3D(seed, x2, y3, z3),
              valCoord3D(seed, x3, y3, z3),
            ),
          ),
        ) *
        CUBIC_3D_BOUNDING;
  }

  @override
  double getNoise2(double x, double y) {
    x *= frequency;
    y *= frequency;

    return singleCubic2(seed, x, y);
  }

  static const double CUBIC_2D_BOUNDING = 1.0 / (1.5 * 1.5);

  double singleCubic2(int seed, double x, double y) {
    final x1 = x.floor(), y1 = y.floor();
    final x0 = x1 - 1,
        y0 = y1 - 1,
        x2 = x1 + 1,
        y2 = y1 + 1,
        x3 = x1 + 2,
        y3 = y1 + 2;
    final xs = x - x1, ys = y - y1;

    return ys.cubicLerp(
          xs.cubicLerp(
            valCoord2D(seed, x0, y0),
            valCoord2D(seed, x1, y0),
            valCoord2D(seed, x2, y0),
            valCoord2D(seed, x3, y0),
          ),
          xs.cubicLerp(
            valCoord2D(seed, x0, y1),
            valCoord2D(seed, x1, y1),
            valCoord2D(seed, x2, y1),
            valCoord2D(seed, x3, y1),
          ),
          xs.cubicLerp(
            valCoord2D(seed, x0, y2),
            valCoord2D(seed, x1, y2),
            valCoord2D(seed, x2, y2),
            valCoord2D(seed, x3, y2),
          ),
          xs.cubicLerp(
            valCoord2D(seed, x0, y3),
            valCoord2D(seed, x1, y3),
            valCoord2D(seed, x2, y3),
            valCoord2D(seed, x3, y3),
          ),
        ) *
        CUBIC_2D_BOUNDING;
  }
}
