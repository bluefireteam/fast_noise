import 'package:fast_noise/fast_noise.dart';

class ValueNoise implements Noise2And3 {
  final int seed;
  final double frequency;
  final Interp interp;

  ValueNoise({
    this.seed = 1337,
    this.frequency = .01,
    this.interp = Interp.quintic,
  });

  @override
  double getNoise3(double x, double y, double z) =>
      singleValue3(seed, x * frequency, y * frequency, z * frequency);

  double singleValue3(int seed, double x, double y, double z) {
    final x0 = x.floor();
    final y0 = y.floor();
    final z0 = z.floor();
    final x1 = x0 + 1;
    final y1 = y0 + 1;
    final z1 = z0 + 1;
    double xs;
    double ys;
    double zs;

    switch (interp) {
      case Interp.linear:
        xs = x - x0;
        ys = y - y0;
        zs = z - z0;
        break;
      case Interp.hermite:
        xs = (x - x0).interpHermiteFunc;
        ys = (y - y0).interpHermiteFunc;
        zs = (z - z0).interpHermiteFunc;
        break;
      case Interp.quintic:
        xs = (x - x0).interpQuinticFunc;
        ys = (y - y0).interpQuinticFunc;
        zs = (z - z0).interpQuinticFunc;
        break;
    }

    final xf00 = xs.lerp(
      valCoord3D(seed, x0, y0, z0),
      valCoord3D(seed, x1, y0, z0),
    );
    final xf10 = xs.lerp(
      valCoord3D(seed, x0, y1, z0),
      valCoord3D(seed, x1, y1, z0),
    );
    final xf01 = xs.lerp(
      valCoord3D(seed, x0, y0, z1),
      valCoord3D(seed, x1, y0, z1),
    );
    final xf11 = xs.lerp(
      valCoord3D(seed, x0, y1, z1),
      valCoord3D(seed, x1, y1, z1),
    );

    return zs.lerp(
      ys.lerp(
        xf00,
        xf10,
      ),
      ys.lerp(
        xf01,
        xf11,
      ),
    );
  }

  @override
  double getNoise2(double x, double y) =>
      singleValue2(seed, x * frequency, y * frequency);

  double singleValue2(int seed, double x, double y) {
    final x0 = x.floor();
    final y0 = y.floor();
    final x1 = x0 + 1;
    final y1 = y0 + 1;
    double xs;
    double ys;

    switch (interp) {
      case Interp.linear:
        xs = x - x0;
        ys = y - y0;
        break;
      case Interp.hermite:
        xs = (x - x0).interpHermiteFunc;
        ys = (y - y0).interpHermiteFunc;
        break;
      case Interp.quintic:
        xs = (x - x0).interpQuinticFunc;
        ys = (y - y0).interpQuinticFunc;
        break;
    }

    return ys.lerp(
      xs.lerp(
        valCoord2D(seed, x0, y0),
        valCoord2D(seed, x1, y0),
      ),
      xs.lerp(
        valCoord2D(seed, x0, y1),
        valCoord2D(seed, x1, y1),
      ),
    );
  }
}
