import 'package:fast_noise/src/utils.dart';

import 'package:fast_noise/src/noise/enums.dart';

class SimplexNoise {
  final int seed, octaves;
  final double frequency, lacunarity, gain;
  final Interp interp;
  final FractalType fractalType;
  final CellularReturnType cellularReturnType;
  final double fractalBounding;

  SimplexNoise(
      {this.seed = 1337,
      this.frequency = .01,
      this.interp = Interp.Quintic,
      this.octaves = 3,
      this.lacunarity = 2.0,
      this.gain = .5,
      this.fractalType = FractalType.FBM,
      this.cellularReturnType = CellularReturnType.CellValue})
      : this.fractalBounding = calculateFractalBounding(gain, octaves);

  double getSimplexFractal3(double x, double y, double z) {
    x *= frequency;
    y *= frequency;
    z *= frequency;

    switch (fractalType) {
      case FractalType.FBM:
        return singleSimplexFractalFBM3(x, y, z);
      case FractalType.Billow:
        return singleSimplexFractalBillow3(x, y, z);
      case FractalType.RigidMulti:
        return singleSimplexFractalRigidMulti3(x, y, z);
    }

    return .0;
  }

  double singleSimplexFractalFBM3(double x, double y, double z) {
    int seed = this.seed;
    double sum = singleSimplex3(seed, x, y, z);
    double amp = 1.0;

    for (int i = 1; i < octaves; i++) {
      x *= lacunarity;
      y *= lacunarity;
      z *= lacunarity;

      amp *= gain;
      sum += singleSimplex3(++seed, x, y, z) * amp;
    }

    return sum * fractalBounding;
  }

  double singleSimplexFractalBillow3(double x, double y, double z) {
    int seed = this.seed;
    double sum = singleSimplex3(seed, x, y, z).abs() * 2.0 - 1.0;
    double amp = 1.0;

    for (int i = 1; i < octaves; i++) {
      x *= lacunarity;
      y *= lacunarity;
      z *= lacunarity;

      amp *= gain;
      sum += (singleSimplex3(++seed, x, y, z).abs() * 2.0 - 1.0) * amp;
    }

    return sum * fractalBounding;
  }

  double singleSimplexFractalRigidMulti3(double x, double y, double z) {
    int seed = this.seed;
    double sum = 1.0 - singleSimplex3(seed, x, y, z).abs();
    double amp = 1.0;

    for (int i = 1; i < octaves; i++) {
      x *= lacunarity;
      y *= lacunarity;
      z *= lacunarity;

      amp *= gain;
      sum -= (1.0 - singleSimplex3(++seed, x, y, z).abs()) * amp;
    }

    return sum;
  }

  double getSimplex3(double x, double y, double z) =>
      singleSimplex3(seed, x * frequency, y * frequency, z * frequency);

  static const double F3 = 1.0 / 3.0;
  static const double G3 = 1.0 / 6.0;
  static const double G33 = G3 * 3.0 - 1.0;

  double singleSimplex3(int seed, double x, double y, double z) {
    double t = (x + y + z) * F3;
    int i = fastFloor(x + t), j = fastFloor(y + t), k = fastFloor(z + t);

    t = (i + j + k) * G3;

    double x0 = x - (i - t), y0 = y - (j - t), z0 = z - (k - t);

    int i1, j1, k1, i2, j2, k2;

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

    double x1 = x0 - i1 + G3,
        y1 = y0 - j1 + G3,
        z1 = z0 - k1 + G3,
        x2 = x0 - i2 + F3,
        y2 = y0 - j2 + F3,
        z2 = z0 - k2 + F3,
        x3 = x0 + G33,
        y3 = y0 + G33,
        z3 = z0 + G33,
        n0,
        n1,
        n2,
        n3;

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

  double getSimplexFractal2(double x, double y) {
    x *= frequency;
    y *= frequency;

    switch (fractalType) {
      case FractalType.FBM:
        return singleSimplexFractalFBM2(x, y);
      case FractalType.Billow:
        return singleSimplexFractalBillow2(x, y);
      case FractalType.RigidMulti:
        return singleSimplexFractalRigidMulti2(x, y);
    }

    return .0;
  }

  double singleSimplexFractalFBM2(double x, double y) {
    int seed = this.seed;
    double sum = singleSimplex2(seed, x, y);
    double amp = 1.0;

    for (int i = 1; i < octaves; i++) {
      x *= lacunarity;
      y *= lacunarity;

      amp *= gain;
      sum += singleSimplex2(++seed, x, y) * amp;
    }

    return sum * fractalBounding;
  }

  double singleSimplexFractalBillow2(double x, double y) {
    int seed = this.seed;
    double sum = singleSimplex2(seed, x, y).abs() * 2.0 - 1.0;
    double amp = 1.0;

    for (int i = 1; i < octaves; i++) {
      x *= lacunarity;
      y *= lacunarity;

      amp *= gain;
      sum += (singleSimplex2(++seed, x, y).abs() * 2.0 - 1.0) * amp;
    }

    return sum * fractalBounding;
  }

  double singleSimplexFractalRigidMulti2(double x, double y) {
    int seed = this.seed;
    double sum = 1.0 - singleSimplex2(seed, x, y).abs();
    double amp = 1.0;

    for (int i = 1; i < octaves; i++) {
      x *= lacunarity;
      y *= lacunarity;

      amp *= gain;
      sum -= (1.0 - singleSimplex2(++seed, x, y).abs()) * amp;
    }

    return sum;
  }

  double getSimplex2(double x, double y) =>
      singleSimplex2(seed, x * frequency, y * frequency);

  static const double F2 = 1.0 / 2.0;
  static const double G2 = 1.0 / 4.0;

  double singleSimplex2(int seed, double x, double y) {
    double t = (x + y) * F2;
    int i = fastFloor(x + t), j = fastFloor(y + t);

    t = (i + j) * G2;
    double X0 = i - t, Y0 = j - t, x0 = x - X0, y0 = y - Y0;

    int i1, j1;
    if (x0 > y0) {
      i1 = 1;
      j1 = 0;
    } else {
      i1 = 0;
      j1 = 1;
    }

    double x1 = x0 - i1 + G2,
        y1 = y0 - j1 + G2,
        x2 = x0 - 1 + F2,
        y2 = y0 - 1 + F2,
        n0,
        n1,
        n2;

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

  double getSimplex4(double x, double y, double z, double w) => singleSimplex4(
      seed, x * frequency, y * frequency, z * frequency, w * frequency);

  static const List<int> SIMPLEX_4D = <int>[
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

  static const double F4 = (2.23606797 - 1.0) / 4.0;
  static const double G4 = (5.0 - 2.23606797) / 20.0;

  double singleSimplex4(int seed, double x, double y, double z, double w) {
    double n0, n1, n2, n3, n4, t = (x + y + z + w) * F4;
    int i = fastFloor(x + t),
        j = fastFloor(y + t),
        k = fastFloor(z + t),
        l = fastFloor(w + t);

    t = (i + j + k + l) * G4;

    double X0 = i - t,
        Y0 = j - t,
        Z0 = k - t,
        W0 = l - t,
        x0 = x - X0,
        y0 = y - Y0,
        z0 = z - Z0,
        w0 = w - W0;

    int c = (x0 > y0) ? 32 : 0;

    c += (x0 > z0) ? 16 : 0;
    c += (y0 > z0) ? 8 : 0;
    c += (x0 > w0) ? 4 : 0;
    c += (y0 > w0) ? 2 : 0;
    c += (z0 > w0) ? 1 : 0;
    c <<= 2;

    int i1 = SIMPLEX_4D[c] >= 3 ? 1 : 0,
        i2 = SIMPLEX_4D[c] >= 2 ? 1 : 0,
        i3 = SIMPLEX_4D[c++] >= 1 ? 1 : 0,
        j1 = SIMPLEX_4D[c] >= 3 ? 1 : 0,
        j2 = SIMPLEX_4D[c] >= 2 ? 1 : 0,
        j3 = SIMPLEX_4D[c++] >= 1 ? 1 : 0,
        k1 = SIMPLEX_4D[c] >= 3 ? 1 : 0,
        k2 = SIMPLEX_4D[c] >= 2 ? 1 : 0,
        k3 = SIMPLEX_4D[c++] >= 1 ? 1 : 0,
        l1 = SIMPLEX_4D[c] >= 3 ? 1 : 0,
        l2 = SIMPLEX_4D[c] >= 2 ? 1 : 0,
        l3 = SIMPLEX_4D[c] >= 1 ? 1 : 0;

    double x1 = x0 - i1 + G4,
        y1 = y0 - j1 + G4,
        z1 = z0 - k1 + G4,
        w1 = w0 - l1 + G4,
        x2 = x0 - i2 + 2 * G4,
        y2 = y0 - j2 + 2 * G4,
        z2 = z0 - k2 + 2 * G4,
        w2 = w0 - l2 + 2 * G4,
        x3 = x0 - i3 + 3 * G4,
        y3 = y0 - j3 + 3 * G4,
        z3 = z0 - k3 + 3 * G4,
        w3 = w0 - l3 + 3 * G4,
        x4 = x0 - 1 + 4 * G4,
        y4 = y0 - 1 + 4 * G4,
        z4 = z0 - 1 + 4 * G4,
        w4 = w0 - 1 + 4 * G4;

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
