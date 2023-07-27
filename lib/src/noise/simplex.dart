import 'package:fast_noise/fast_noise.dart';

class SimplexNoise
    implements Noise2And3, Noise4, Noise2Int, Noise3Int, Noise4Int {
  final int seed;
  final double frequency;

  SimplexNoise({
    this.seed = 1337,
    this.frequency = .01,
  });

  @override
  double getNoiseInt3(int x, int y, int z) => singleSimplex3(seed, x, y, z);

  @override
  double getNoise3(double x, double y, double z) => singleSimplex3(
        seed,
        (x * frequency).toInt(),
        (y * frequency).toInt(),
        (z * frequency).toInt(),
      );

  static const double _f3 = 1.0 / 3.0;
  static const double _g3 = 1.0 / 6.0;
  static const double _g33 = _g3 * 3.0 - 1.0;

  double singleSimplex3(int seed, int x, int y, int z) {
    var t = (x + y + z) * _f3;
    final i = x + t.floor();
    final j = y + t.floor();
    final k = z + t.floor();

    t = (i + j + k) * _g3;

    final x0 = x - (i - t);
    final y0 = y - (j - t);
    final z0 = z - (k - t);

    int i1;
    int j1;
    int k1;
    int i2;
    int j2;
    int k2;

    if (x0 >= y0) {
      if (y0 >= z0) {
        i1 = 1;
        j1 = 0;
        k1 = 0;
        i2 = 1;
        j2 = 1;
        k2 = 0;
      } else if (x0 >= z0) {
        i1 = 1;
        j1 = 0;
        k1 = 0;
        i2 = 1;
        j2 = 0;
        k2 = 1;
      } else // x0 < z0
      {
        i1 = 0;
        j1 = 0;
        k1 = 1;
        i2 = 1;
        j2 = 0;
        k2 = 1;
      }
    } else // x0 < y0
    {
      if (y0 < z0) {
        i1 = 0;
        j1 = 0;
        k1 = 1;
        i2 = 0;
        j2 = 1;
        k2 = 1;
      } else if (x0 < z0) {
        i1 = 0;
        j1 = 1;
        k1 = 0;
        i2 = 0;
        j2 = 1;
        k2 = 1;
      } else // x0 >= z0
      {
        i1 = 0;
        j1 = 1;
        k1 = 0;
        i2 = 1;
        j2 = 1;
        k2 = 0;
      }
    }

    final x1 = x0 - i1 + _g3;
    final y1 = y0 - j1 + _g3;
    final z1 = z0 - k1 + _g3;
    final x2 = x0 - i2 + _f3;
    final y2 = y0 - j2 + _f3;
    final z2 = z0 - k2 + _f3;
    final x3 = x0 + _g33;
    final y3 = y0 + _g33;
    final z3 = z0 + _g33;
    final double n0;
    final double n1;
    final double n2;
    final double n3;

    t = 0.6 - x0 * x0 - y0 * y0 - z0 * z0;

    if (t < 0) {
      n0 = .0;
    } else {
      t *= t;
      n0 = t * t * gradCoord3D(seed, i, j, k, x0, y0, z0);
    }

    t = 0.6 - x1 * x1 - y1 * y1 - z1 * z1;
    if (t < 0) {
      n1 = .0;
    } else {
      t *= t;
      n1 = t * t * gradCoord3D(seed, i + i1, j + j1, k + k1, x1, y1, z1);
    }

    t = 0.6 - x2 * x2 - y2 * y2 - z2 * z2;
    if (t < 0) {
      n2 = .0;
    } else {
      t *= t;
      n2 = t * t * gradCoord3D(seed, i + i2, j + j2, k + k2, x2, y2, z2);
    }

    t = 0.6 - x3 * x3 - y3 * y3 - z3 * z3;
    if (t < 0) {
      n3 = .0;
    } else {
      t *= t;
      n3 = t * t * gradCoord3D(seed, i + 1, j + 1, k + 1, x3, y3, z3);
    }

    return 32 * (n0 + n1 + n2 + n3);
  }

  @override
  double getNoise2(double x, double y) =>
      singleSimplex2(seed, (x * frequency).toInt(), (y * frequency).toInt());

  @override
  double getNoiseInt2(int x, int y) => singleSimplex2(seed, x, y);

  static const double _f2 = 1.0 / 2.0;
  static const double _g2 = 1.0 / 4.0;

  double singleSimplex2(int seed, int x, int y) {
    var t = (x + y) * _f2;
    final i = x + t.floor();
    final j = y + t.floor();

    t = (i + j) * _g2;

    final x0 = x - (i - t);
    final y0 = y - (j - t);

    final int i1;
    final int j1;
    if (x0 > y0) {
      i1 = 1;
      j1 = 0;
    } else {
      i1 = 0;
      j1 = 1;
    }

    final x1 = x0 - i1 + _g2;
    final y1 = y0 - j1 + _g2;
    final x2 = x0 - 1 + _f2;
    final y2 = y0 - 1 + _f2;
    final double n0;
    final double n1;
    final double n2;

    t = 0.5 - x0 * x0 - y0 * y0;

    if (t < 0) {
      n0 = .0;
    } else {
      t *= t;
      n0 = t * t * gradCoord2D(seed, i, j, x0, y0);
    }

    t = 0.5 - x1 * x1 - y1 * y1;

    if (t < 0) {
      n1 = .0;
    } else {
      t *= t;
      n1 = t * t * gradCoord2D(seed, i + i1, j + j1, x1, y1);
    }

    t = 0.5 - x2 * x2 - y2 * y2;

    if (t < 0) {
      n2 = .0;
    } else {
      t *= t;
      n2 = t * t * gradCoord2D(seed, i + 1, j + 1, x2, y2);
    }

    return 50 * (n0 + n1 + n2);
  }

  @override
  double getNoise4(double x, double y, double z, double w) => singleSimplex4(
        seed,
        (x * frequency).toInt(),
        (y * frequency).toInt(),
        (z * frequency).toInt(),
        (w * frequency).toInt(),
      );

  @override
  double getNoiseInt4(int x, int y, int z, int w) =>
      singleSimplex4(seed, x, y, z, w);

  static const List<int> _simplex4d = [
    0,
    1,
    2,
    3,
    0,
    1,
    3,
    2,
    0,
    0,
    0,
    0,
    0,
    2,
    3,
    1,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    1,
    2,
    3,
    0,
    0,
    2,
    1,
    3,
    0,
    0,
    0,
    0,
    0,
    3,
    1,
    2,
    0,
    3,
    2,
    1,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    1,
    3,
    2,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    1,
    2,
    0,
    3,
    0,
    0,
    0,
    0,
    1,
    3,
    0,
    2,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    2,
    3,
    0,
    1,
    2,
    3,
    1,
    0,
    1,
    0,
    2,
    3,
    1,
    0,
    3,
    2,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    2,
    0,
    3,
    1,
    0,
    0,
    0,
    0,
    2,
    1,
    3,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    2,
    0,
    1,
    3,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    3,
    0,
    1,
    2,
    3,
    0,
    2,
    1,
    0,
    0,
    0,
    0,
    3,
    1,
    2,
    0,
    2,
    1,
    0,
    3,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    3,
    1,
    0,
    2,
    0,
    0,
    0,
    0,
    3,
    2,
    0,
    1,
    3,
    2,
    1,
    0
  ];

  static const double _f4 = (2.23606797 - 1.0) / 4.0;
  static const double _g4 = (5.0 - 2.23606797) / 20.0;

  double singleSimplex4(int seed, int x, int y, int z, int w) {
    final double n0;
    final double n1;
    final double n2;
    final double n3;
    final double n4;
    var t = (x + y + z + w) * _f4;
    final i = x + t.floor();
    final j = y + t.floor();
    final k = z + t.floor();
    final l = w + t.floor();

    t = (i + j + k + l) * _g4;

    final x0 = x - (i - t);
    final y0 = y - (j - t);
    final z0 = z - (k - t);
    final w0 = w - (l - t);

    var c = (x0 > y0) ? 32 : 0;

    c += (x0 > z0) ? 16 : 0;
    c += (y0 > z0) ? 8 : 0;
    c += (x0 > w0) ? 4 : 0;
    c += (y0 > w0) ? 2 : 0;
    c += (z0 > w0) ? 1 : 0;
    c <<= 2;

    final i1 = _simplex4d[c] >= 3 ? 1 : 0;
    final i2 = _simplex4d[c] >= 2 ? 1 : 0;
    final i3 = _simplex4d[c++] >= 1 ? 1 : 0;
    final j1 = _simplex4d[c] >= 3 ? 1 : 0;
    final j2 = _simplex4d[c] >= 2 ? 1 : 0;
    final j3 = _simplex4d[c++] >= 1 ? 1 : 0;
    final k1 = _simplex4d[c] >= 3 ? 1 : 0;
    final k2 = _simplex4d[c] >= 2 ? 1 : 0;
    final k3 = _simplex4d[c++] >= 1 ? 1 : 0;
    final l1 = _simplex4d[c] >= 3 ? 1 : 0;
    final l2 = _simplex4d[c] >= 2 ? 1 : 0;
    final l3 = _simplex4d[c] >= 1 ? 1 : 0;

    final x1 = x0 - i1 + _g4;
    final y1 = y0 - j1 + _g4;
    final z1 = z0 - k1 + _g4;
    final w1 = w0 - l1 + _g4;
    final x2 = x0 - i2 + 2 * _g4;
    final y2 = y0 - j2 + 2 * _g4;
    final z2 = z0 - k2 + 2 * _g4;
    final w2 = w0 - l2 + 2 * _g4;
    final x3 = x0 - i3 + 3 * _g4;
    final y3 = y0 - j3 + 3 * _g4;
    final z3 = z0 - k3 + 3 * _g4;
    final w3 = w0 - l3 + 3 * _g4;
    final x4 = x0 - 1 + 4 * _g4;
    final y4 = y0 - 1 + 4 * _g4;
    final z4 = z0 - 1 + 4 * _g4;
    final w4 = w0 - 1 + 4 * _g4;

    t = 0.6 - x0 * x0 - y0 * y0 - z0 * z0 - w0 * w0;

    if (t < 0) {
      n0 = .0;
    } else {
      t *= t;
      n0 = t * t * gradCoord4D(seed, i, j, k, l, x0, y0, z0, w0);
    }

    t = 0.6 - x1 * x1 - y1 * y1 - z1 * z1 - w1 * w1;

    if (t < 0) {
      n1 = .0;
    } else {
      t *= t;
      n1 = t *
          t *
          gradCoord4D(seed, i + i1, j + j1, k + k1, l + l1, x1, y1, z1, w1);
    }

    t = 0.6 - x2 * x2 - y2 * y2 - z2 * z2 - w2 * w2;

    if (t < 0) {
      n2 = .0;
    } else {
      t *= t;
      n2 = t *
          t *
          gradCoord4D(seed, i + i2, j + j2, k + k2, l + l2, x2, y2, z2, w2);
    }

    t = 0.6 - x3 * x3 - y3 * y3 - z3 * z3 - w3 * w3;

    if (t < 0) {
      n3 = .0;
    } else {
      t *= t;
      n3 = t *
          t *
          gradCoord4D(seed, i + i3, j + j3, k + k3, l + l3, x3, y3, z3, w3);
    }

    t = 0.6 - x4 * x4 - y4 * y4 - z4 * z4 - w4 * w4;

    if (t < 0) {
      n4 = .0;
    } else {
      t *= t;
      n4 =
          t * t * gradCoord4D(seed, i + 1, j + 1, k + 1, l + 1, x4, y4, z4, w4);
    }

    return 27 * (n0 + n1 + n2 + n3 + n4);
  }
}
