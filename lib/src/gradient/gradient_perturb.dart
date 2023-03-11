import 'package:fast_noise/fast_noise.dart';
import 'package:fast_noise/src/types.dart';
import 'package:fast_noise/src/utils.dart';

class GradientPerturb {
  static const double gradientPerturbAmp = 1.0 / 0.45;

  final CellularNoise baseNoise;

  GradientPerturb(this.baseNoise);

  void gradientPerturb3(Vector3f v3) => singleGradientPerturb3(
        baseNoise.seed,
        gradientPerturbAmp,
        baseNoise.frequency,
        v3,
      );

  void gradientPerturbFractal3(Vector3f v3) {
    var seed = baseNoise.seed;
    var amp = gradientPerturbAmp * baseNoise.fractalBounding,
        freq = baseNoise.frequency;

    singleGradientPerturb3(seed, amp, baseNoise.frequency, v3);

    for (var i = 1; i < baseNoise.octaves; i++) {
      freq *= baseNoise.lacunarity;
      amp *= baseNoise.gain;
      singleGradientPerturb3(++seed, amp, freq, v3);
    }
  }

  void singleGradientPerturb3(
      int seed, double perturbAmp, double frequency, Vector3f v3) {
    final xf = v3.x * frequency, yf = v3.y * frequency, zf = v3.z * frequency;
    var x0 = xf.floor(),
        y0 = yf.floor(),
        z0 = zf.floor(),
        x1 = x0 + 1,
        y1 = y0 + 1,
        z1 = z0 + 1;

    double xs, ys, zs;
    switch (baseNoise.interp) {
      case Interp.Linear:
        xs = xf - x0;
        ys = yf - y0;
        zs = zf - z0;
        break;
      case Interp.Hermite:
        xs = (xf - x0).interpHermiteFunc;
        ys = (yf - y0).interpHermiteFunc;
        zs = (zf - z0).interpHermiteFunc;
        break;
      case Interp.Quintic:
        xs = (xf - x0).interpQuinticFunc;
        ys = (yf - y0).interpQuinticFunc;
        zs = (zf - z0).interpQuinticFunc;
        break;
    }

    var vec0 = CELL_3D[hash3D(seed, x0, y0, z0) & 255],
        vec1 = CELL_3D[hash3D(seed, x1, y0, z0) & 255];

    var lx0x = xs.lerp(vec0.x, vec1.x),
        ly0x = xs.lerp(vec0.y, vec1.y),
        lz0x = xs.lerp(vec0.z, vec1.z);

    vec0 = CELL_3D[hash3D(seed, x0, y1, z0) & 255];
    vec1 = CELL_3D[hash3D(seed, x1, y1, z0) & 255];

    var lx1x = xs.lerp(vec0.x, vec1.x),
        ly1x = xs.lerp(vec0.y, vec1.y),
        lz1x = xs.lerp(vec0.z, vec1.z),
        lx0y = ys.lerp(lx0x, lx1x),
        ly0y = ys.lerp(ly0x, ly1x),
        lz0y = ys.lerp(lz0x, lz1x);

    vec0 = CELL_3D[hash3D(seed, x0, y0, z1) & 255];
    vec1 = CELL_3D[hash3D(seed, x1, y0, z1) & 255];

    lx0x = xs.lerp(vec0.x, vec1.x);
    ly0x = xs.lerp(vec0.y, vec1.y);
    lz0x = xs.lerp(vec0.z, vec1.z);

    vec0 = CELL_3D[hash3D(seed, x0, y1, z1) & 255];
    vec1 = CELL_3D[hash3D(seed, x1, y1, z1) & 255];

    lx1x = xs.lerp(vec0.x, vec1.x);
    ly1x = xs.lerp(vec0.y, vec1.y);
    lz1x = xs.lerp(vec0.z, vec1.z);

    v3.x += zs.lerp(lx0y, ys.lerp(lx0x, lx1x)) * perturbAmp;
    v3.y += zs.lerp(ly0y, ys.lerp(ly0x, ly1x)) * perturbAmp;
    v3.z += zs.lerp(lz0y, ys.lerp(lz0x, lz1x)) * perturbAmp;
  }

  void gradientPerturb2(Vector2f v2) => singleGradientPerturb2(
        baseNoise.seed,
        gradientPerturbAmp,
        baseNoise.frequency,
        v2,
      );

  void gradientPerturbFractal2(Vector2f v2) {
    var seed = baseNoise.seed;
    var amp = gradientPerturbAmp * baseNoise.fractalBounding,
        freq = baseNoise.frequency;

    singleGradientPerturb2(seed, amp, baseNoise.frequency, v2);

    for (var i = 1; i < baseNoise.octaves; i++) {
      freq *= baseNoise.lacunarity;
      amp *= baseNoise.gain;
      singleGradientPerturb2(++seed, amp, freq, v2);
    }
  }

  void singleGradientPerturb2(
    int seed,
    double perturbAmp,
    double frequency,
    Vector2f v2,
  ) {
    final xf = v2.x * frequency, yf = v2.y * frequency;
    final x0 = xf.floor(), y0 = yf.floor(), x1 = x0 + 1, y1 = y0 + 1;

    double xs, ys;
    switch (baseNoise.interp) {
      case Interp.Linear:
        xs = xf - x0;
        ys = yf - y0;
        break;
      case Interp.Hermite:
        xs = (xf - x0).interpHermiteFunc;
        ys = (yf - y0).interpHermiteFunc;
        break;
      case Interp.Quintic:
        xs = (xf - x0).interpQuinticFunc;
        ys = (yf - y0).interpQuinticFunc;
        break;
    }

    var vec0 = CELL_2D[hash2D(seed, x0, y0) & 255],
        vec1 = CELL_2D[hash2D(seed, x1, y0) & 255];

    final lx0x = xs.lerp(vec0.x, vec1.x), ly0x = xs.lerp(vec0.y, vec1.y);

    vec0 = CELL_2D[hash2D(seed, x0, y1) & 255];
    vec1 = CELL_2D[hash2D(seed, x1, y1) & 255];

    final lx1x = xs.lerp(vec0.x, vec1.x), ly1x = xs.lerp(vec0.y, vec1.y);

    v2.x += ys.lerp(lx0x, lx1x) * perturbAmp;
    v2.y += ys.lerp(ly0x, ly1x) * perturbAmp;
  }
}
