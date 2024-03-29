import 'package:fast_noise/fast_noise.dart';

class GradientPerturb {
  static const double gradientPerturbAmp = 1.0 / 0.45;

  final int seed;
  final double frequency;
  final int octaves;
  final double gain;
  final double lacunarity;
  final Interp interp;
  final double fractalBounding;

  GradientPerturb({
    this.seed = 1337,
    this.frequency = .01,
    this.gain = 0.5,
    this.lacunarity = 2.0,
    this.octaves = 3,
    this.interp = Interp.quintic,
  }) : fractalBounding = calculateFractalBounding(octaves, gain);

  void gradientPerturb3(Vector3f v3) => singleGradientPerturb3(
        seed,
        gradientPerturbAmp,
        frequency,
        v3,
      );

  void gradientPerturbFractal3(Vector3f v3) {
    var seed = this.seed;
    var amp = gradientPerturbAmp * fractalBounding;
    var freq = frequency;

    singleGradientPerturb3(seed, amp, frequency, v3);

    for (var i = 1; i < octaves; i++) {
      freq *= lacunarity;
      amp *= gain;
      singleGradientPerturb3(++seed, amp, freq, v3);
    }
  }

  void singleGradientPerturb3(
    int seed,
    double perturbAmp,
    double frequency,
    Vector3f v3,
  ) {
    final xf = v3.x * frequency;
    final yf = v3.y * frequency;
    final zf = v3.z * frequency;
    final x0 = xf.floor();
    final y0 = yf.floor();
    final z0 = zf.floor();
    final x1 = x0 + 1;
    final y1 = y0 + 1;
    final z1 = z0 + 1;

    double xs;
    double ys;
    double zs;
    switch (interp) {
      case Interp.linear:
        xs = xf - x0;
        ys = yf - y0;
        zs = zf - z0;
        break;
      case Interp.hermite:
        xs = (xf - x0).interpHermiteFunc;
        ys = (yf - y0).interpHermiteFunc;
        zs = (zf - z0).interpHermiteFunc;
        break;
      case Interp.quintic:
        xs = (xf - x0).interpQuinticFunc;
        ys = (yf - y0).interpQuinticFunc;
        zs = (zf - z0).interpQuinticFunc;
        break;
    }

    var vec0 = cell3d[hash3D(seed, x0, y0, z0) & 255];
    var vec1 = cell3d[hash3D(seed, x1, y0, z0) & 255];

    var lx0x = xs.lerp(vec0.x, vec1.x);
    var ly0x = xs.lerp(vec0.y, vec1.y);
    var lz0x = xs.lerp(vec0.z, vec1.z);

    vec0 = cell3d[hash3D(seed, x0, y1, z0) & 255];
    vec1 = cell3d[hash3D(seed, x1, y1, z0) & 255];

    var lx1x = xs.lerp(vec0.x, vec1.x);
    var ly1x = xs.lerp(vec0.y, vec1.y);
    var lz1x = xs.lerp(vec0.z, vec1.z);
    final lx0y = ys.lerp(lx0x, lx1x);
    final ly0y = ys.lerp(ly0x, ly1x);
    final lz0y = ys.lerp(lz0x, lz1x);

    vec0 = cell3d[hash3D(seed, x0, y0, z1) & 255];
    vec1 = cell3d[hash3D(seed, x1, y0, z1) & 255];

    lx0x = xs.lerp(vec0.x, vec1.x);
    ly0x = xs.lerp(vec0.y, vec1.y);
    lz0x = xs.lerp(vec0.z, vec1.z);

    vec0 = cell3d[hash3D(seed, x0, y1, z1) & 255];
    vec1 = cell3d[hash3D(seed, x1, y1, z1) & 255];

    lx1x = xs.lerp(vec0.x, vec1.x);
    ly1x = xs.lerp(vec0.y, vec1.y);
    lz1x = xs.lerp(vec0.z, vec1.z);

    v3.x += zs.lerp(lx0y, ys.lerp(lx0x, lx1x)) * perturbAmp;
    v3.y += zs.lerp(ly0y, ys.lerp(ly0x, ly1x)) * perturbAmp;
    v3.z += zs.lerp(lz0y, ys.lerp(lz0x, lz1x)) * perturbAmp;
  }

  void gradientPerturb2(Vector2f v2) => singleGradientPerturb2(
        seed,
        gradientPerturbAmp,
        frequency,
        v2,
      );

  void gradientPerturbFractal2(Vector2f v2) {
    var seed = this.seed;
    var amp = gradientPerturbAmp * fractalBounding;
    var freq = frequency;

    singleGradientPerturb2(seed, amp, frequency, v2);

    for (var i = 1; i < octaves; i++) {
      freq *= lacunarity;
      amp *= gain;
      singleGradientPerturb2(++seed, amp, freq, v2);
    }
  }

  void singleGradientPerturb2(
    int seed,
    double perturbAmp,
    double frequency,
    Vector2f v2,
  ) {
    final xf = v2.x * frequency;
    final yf = v2.y * frequency;
    final x0 = xf.floor();
    final y0 = yf.floor();
    final x1 = x0 + 1;
    final y1 = y0 + 1;

    final double xs;
    final double ys;
    switch (interp) {
      case Interp.linear:
        xs = xf - x0;
        ys = yf - y0;
        break;
      case Interp.hermite:
        xs = (xf - x0).interpHermiteFunc;
        ys = (yf - y0).interpHermiteFunc;
        break;
      case Interp.quintic:
        xs = (xf - x0).interpQuinticFunc;
        ys = (yf - y0).interpQuinticFunc;
        break;
    }

    var vec0 = cell2d[hash2D(seed, x0, y0) & 255];
    var vec1 = cell2d[hash2D(seed, x1, y0) & 255];

    final lx0x = xs.lerp(vec0.x, vec1.x);
    final ly0x = xs.lerp(vec0.y, vec1.y);

    vec0 = cell2d[hash2D(seed, x0, y1) & 255];
    vec1 = cell2d[hash2D(seed, x1, y1) & 255];

    final lx1x = xs.lerp(vec0.x, vec1.x);
    final ly1x = xs.lerp(vec0.y, vec1.y);

    v2.x += ys.lerp(lx0x, lx1x) * perturbAmp;
    v2.y += ys.lerp(ly0x, ly1x) * perturbAmp;
  }
}
