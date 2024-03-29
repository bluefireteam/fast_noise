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
    this.fractalType = FractalType.fbm,
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
    final xd = x.toDouble();
    final yd = y.toDouble();
    final zd = z.toDouble();
    return getNoise3(xd, yd, zd);
  }

  @override
  double getNoise3(double x, double y, double z) {
    final dx = (x * frequency).toInt();
    final dy = (y * frequency).toInt();
    final dz = (z * frequency).toInt();

    switch (fractalType) {
      case FractalType.fbm:
        return singleSimplexFractalFBM3(dx, dy, dz);
      case FractalType.billow:
        return singleSimplexFractalBillow3(dx, dy, dz);
      case FractalType.rigidMulti:
        return singleSimplexFractalRigidMulti3(dx, dy, dz);
    }
  }

  double singleSimplexFractalFBM3(int x, int y, int z) {
    var seed = this.seed;
    var sum = baseNoise.singleSimplex3(seed, x, y, z);
    var amp = 1.0;
    var x1 = x.toDouble();
    var y1 = y.toDouble();
    var z1 = z.toDouble();

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
    var sum = baseNoise.singleSimplex3(seed, x, y, z).abs() * 2.0 - 1.0;
    var amp = 1.0;
    var x1 = x.toDouble();
    var y1 = y.toDouble();
    var z1 = z.toDouble();

    for (var i = 1; i < octaves; i++) {
      x1 *= lacunarity;
      y1 *= lacunarity;
      z1 *= lacunarity;

      amp *= gain;
      sum += (baseNoise
                      .singleSimplex3(
                        ++seed,
                        x1.toInt(),
                        y1.toInt(),
                        z1.toInt(),
                      )
                      .abs() *
                  2.0 -
              1.0) *
          amp;
    }

    return sum * fractalBounding;
  }

  double singleSimplexFractalRigidMulti3(int x, int y, int z) {
    var seed = this.seed;
    var sum = 1.0 - baseNoise.singleSimplex3(seed, x, y, z).abs();
    var amp = 1.0;
    var x1 = x.toDouble();
    var y1 = y.toDouble();
    var z1 = z.toDouble();

    for (var i = 1; i < octaves; i++) {
      x1 *= lacunarity;
      y1 *= lacunarity;
      z1 *= lacunarity;

      amp *= gain;
      final baseValue = baseNoise.singleSimplex3(
        ++seed,
        x1.toInt(),
        y1.toInt(),
        z1.toInt(),
      );
      sum -= (1.0 - baseValue.abs()) * amp;
    }

    return sum;
  }

  @override
  double getNoiseInt2(int x, int y) {
    final xd = x.toDouble();
    final yd = y.toDouble();
    return getNoise2(xd, yd);
  }

  @override
  double getNoise2(double x, double y) {
    final dx = (x * frequency).toInt();
    final dy = (y * frequency).toInt();

    switch (fractalType) {
      case FractalType.fbm:
        return singleSimplexFractalFBM2(dx, dy);
      case FractalType.billow:
        return singleSimplexFractalBillow2(dx, dy);
      case FractalType.rigidMulti:
        return singleSimplexFractalRigidMulti2(dx, dy);
    }
  }

  double singleSimplexFractalFBM2(int x, int y) {
    var seed = this.seed;
    var sum = baseNoise.singleSimplex2(seed, x, y);
    var amp = 1.0;
    var x1 = x.toDouble();
    var y1 = y.toDouble();

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
    var sum = baseNoise.singleSimplex2(seed, x, y).abs() * 2.0 - 1.0;
    var amp = 1.0;
    var x1 = x.toDouble();
    var y1 = y.toDouble();

    for (var i = 1; i < octaves; i++) {
      x1 *= lacunarity;
      y1 *= lacunarity;

      amp *= gain;
      final baseValue = baseNoise.singleSimplex2(
        ++seed,
        x1.toInt(),
        y1.toInt(),
      );
      sum += (baseValue.abs() * 2.0 - 1.0) * amp;
    }

    return sum * fractalBounding;
  }

  double singleSimplexFractalRigidMulti2(int x, int y) {
    var seed = this.seed;
    var sum = 1.0 - baseNoise.singleSimplex2(seed, x, y).abs();
    var amp = 1.0;
    var x1 = x.toDouble();
    var y1 = y.toDouble();

    for (var i = 1; i < octaves; i++) {
      x1 *= lacunarity;
      y1 *= lacunarity;

      amp *= gain;
      final baseValue = baseNoise.singleSimplex2(
        ++seed,
        x1.toInt(),
        y1.toInt(),
      );
      sum -= (1.0 - baseValue.abs()) * amp;
    }

    return sum;
  }
}
