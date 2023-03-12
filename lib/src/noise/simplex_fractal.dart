import 'package:fast_noise/fast_noise.dart';

class SimplexFractalNoise implements Noise2And3, Noise2Int, Noise3Int {
  final SimplexNoise baseNoise;

  final int seed;
  final double frequency;
  final FractalType fractalType;
  final int octaves;
  final double gain;
  final double lacunarity;
  final double fractalBounding;

  SimplexFractalNoise({
    this.seed = 1337,
    this.frequency = .01,
    this.fractalType = FractalType.FBM,
    this.octaves = 3,
    this.gain = .5,
    this.lacunarity = 2.0,
  })  : baseNoise = SimplexNoise(
          seed: seed,
          frequency: frequency,
        ),
        fractalBounding = calculateFractalBounding(octaves, gain);

  @override
  double getNoiseInt3(int x, int y, int z) {
    var xd = x.toDouble(), yd = y.toDouble(), zd = z.toDouble();
    return getNoise3(xd, yd, zd);
  }

  @override
  double getNoise3(double x, double y, double z) {
    x *= frequency;
    y *= frequency;
    z *= frequency;

    switch (fractalType) {
      case FractalType.FBM:
        return singleSimplexFractalFBM3(x.toInt(), y.toInt(), z.toInt());
      case FractalType.Billow:
        return singleSimplexFractalBillow3(x.toInt(), y.toInt(), z.toInt());
      case FractalType.RigidMulti:
        return singleSimplexFractalRigidMulti3(x.toInt(), y.toInt(), z.toInt());
    }
  }

  double singleSimplexFractalFBM3(int x, int y, int z) {
    var seed = this.seed;
    var sum = baseNoise.singleSimplex3(seed, x, y, z), amp = 1.0;
    var x1 = x.toDouble(), y1 = y.toDouble(), z1 = z.toDouble();

    for (var i = 1; i < octaves; i++) {
      x1 *= lacunarity;
      y1 *= lacunarity;
      z1 *= lacunarity;

      amp *= gain;
      sum +=
          baseNoise.singleSimplex3(++seed, x1.toInt(), y1.toInt(), z1.toInt()) *
              amp;
    }

    return sum * fractalBounding;
  }

  double singleSimplexFractalBillow3(int x, int y, int z) {
    var seed = this.seed;
    var sum = baseNoise.singleSimplex3(seed, x, y, z).abs() * 2.0 - 1.0,
        amp = 1.0;
    var x1 = x.toDouble(), y1 = y.toDouble(), z1 = z.toDouble();

    for (var i = 1; i < octaves; i++) {
      x1 *= lacunarity;
      y1 *= lacunarity;
      z1 *= lacunarity;

      amp *= gain;
      sum += (baseNoise
                      .singleSimplex3(
                          ++seed, x1.toInt(), y1.toInt(), z1.toInt())
                      .abs() *
                  2.0 -
              1.0) *
          amp;
    }

    return sum * fractalBounding;
  }

  double singleSimplexFractalRigidMulti3(int x, int y, int z) {
    var seed = this.seed;
    var sum = 1.0 - baseNoise.singleSimplex3(seed, x, y, z).abs(), amp = 1.0;
    var x1 = x.toDouble(), y1 = y.toDouble(), z1 = z.toDouble();

    for (var i = 1; i < octaves; i++) {
      x1 *= lacunarity;
      y1 *= lacunarity;
      z1 *= lacunarity;

      amp *= gain;
      sum -= (1.0 -
              baseNoise
                  .singleSimplex3(++seed, x1.toInt(), y1.toInt(), z1.toInt())
                  .abs()) *
          amp;
    }

    return sum;
  }

  static const double F3 = 1.0 / 3.0;
  static const double G3 = 1.0 / 6.0;
  static const double G33 = G3 * 3.0 - 1.0;

  @override
  double getNoiseInt2(int x, int y) {
    final xd = x.toDouble(), yd = y.toDouble();
    return getNoise2(xd, yd);
  }

  @override
  double getNoise2(double x, double y) {
    x *= frequency;
    y *= frequency;

    switch (fractalType) {
      case FractalType.FBM:
        return singleSimplexFractalFBM2(x.toInt(), y.toInt());
      case FractalType.Billow:
        return singleSimplexFractalBillow2(x.toInt(), y.toInt());
      case FractalType.RigidMulti:
        return singleSimplexFractalRigidMulti2(x.toInt(), y.toInt());
    }
  }

  double singleSimplexFractalFBM2(int x, int y) {
    var seed = this.seed;
    var sum = baseNoise.singleSimplex2(seed, x, y), amp = 1.0;
    var x1 = x.toDouble(), y1 = y.toDouble();

    for (var i = 1; i < octaves; i++) {
      x1 *= lacunarity;
      y1 *= lacunarity;

      amp *= gain;
      sum += baseNoise.singleSimplex2(++seed, x1.toInt(), y1.toInt()) * amp;
    }

    return sum * fractalBounding;
  }

  double singleSimplexFractalBillow2(int x, int y) {
    var seed = this.seed;
    var sum = baseNoise.singleSimplex2(seed, x, y).abs() * 2.0 - 1.0, amp = 1.0;
    var x1 = x.toDouble(), y1 = y.toDouble();

    for (var i = 1; i < octaves; i++) {
      x1 *= lacunarity;
      y1 *= lacunarity;

      amp *= gain;
      sum += (baseNoise.singleSimplex2(++seed, x1.toInt(), y1.toInt()).abs() *
                  2.0 -
              1.0) *
          amp;
    }

    return sum * fractalBounding;
  }

  double singleSimplexFractalRigidMulti2(int x, int y) {
    var seed = this.seed;
    var sum = 1.0 - baseNoise.singleSimplex2(seed, x, y).abs(), amp = 1.0;
    var x1 = x.toDouble(), y1 = y.toDouble();

    for (var i = 1; i < octaves; i++) {
      x1 *= lacunarity;
      y1 *= lacunarity;

      amp *= gain;
      sum -= (1.0 -
              baseNoise.singleSimplex2(++seed, x1.toInt(), y1.toInt()).abs()) *
          amp;
    }

    return sum;
  }
}
