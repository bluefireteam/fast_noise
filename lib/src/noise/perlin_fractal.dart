import 'package:fast_noise/fast_noise.dart';

class PerlinFractalNoise implements Noise2And3 {
  final PerlinNoise baseNoise;
  final FractalType fractalType;
  final int octaves;
  final double gain;
  final double lacunarity;
  final double fractalBounding;

  PerlinFractalNoise({
    int seed = 1337,
    double frequency = .01,
    Interp interp = Interp.Quintic,
    this.fractalType = FractalType.FBM,
    this.octaves = 3,
    this.gain = .5,
    this.lacunarity = 2.0,
  })  : baseNoise = PerlinNoise(
          seed: seed,
          frequency: frequency,
          interp: interp,
        ),
        fractalBounding = calculateFractalBounding(octaves, gain);

  @override
  double getNoise3(double x, double y, double z) {
    x *= baseNoise.frequency;
    y *= baseNoise.frequency;
    z *= baseNoise.frequency;

    switch (fractalType) {
      case FractalType.FBM:
        return singlePerlinFractalFBM3(x, y, z);
      case FractalType.Billow:
        return singlePerlinFractalBillow3(x, y, z);
      case FractalType.RigidMulti:
        return singlePerlinFractalRigidMulti3(x, y, z);
    }
  }

  double singlePerlinFractalFBM3(double x, double y, double z) {
    var seed = baseNoise.seed;
    var sum = baseNoise.singlePerlin3(seed, x, y, z), amp = 1.0;

    for (var i = 1; i < octaves; i++) {
      x *= lacunarity;
      y *= lacunarity;
      z *= lacunarity;

      amp *= gain;
      sum += baseNoise.singlePerlin3(++seed, x, y, z) * amp;
    }

    return sum * fractalBounding;
  }

  double singlePerlinFractalBillow3(double x, double y, double z) {
    var seed = baseNoise.seed;
    var sum = baseNoise.singlePerlin3(seed, x, y, z).abs() * 2.0 - 1.0,
        amp = 1.0;

    for (var i = 1; i < octaves; i++) {
      x *= lacunarity;
      y *= lacunarity;
      z *= lacunarity;

      amp *= gain;
      sum += (baseNoise.singlePerlin3(++seed, x, y, z).abs() * 2.0 - 1.0) * amp;
    }

    return sum * fractalBounding;
  }

  double singlePerlinFractalRigidMulti3(double x, double y, double z) {
    var seed = baseNoise.seed;
    var sum = 1.0 - baseNoise.singlePerlin3(seed, x, y, z).abs(), amp = 1.0;

    for (var i = 1; i < octaves; i++) {
      x *= lacunarity;
      y *= lacunarity;
      z *= lacunarity;

      amp *= gain;
      sum -= (1.0 - baseNoise.singlePerlin3(++seed, x, y, z).abs()) * amp;
    }

    return sum;
  }

  @override
  double getNoise2(double x, double y) {
    x *= baseNoise.frequency;
    y *= baseNoise.frequency;

    switch (fractalType) {
      case FractalType.FBM:
        return singlePerlinFractalFBM2(x, y);
      case FractalType.Billow:
        return singlePerlinFractalBillow2(x, y);
      case FractalType.RigidMulti:
        return singlePerlinFractalRigidMulti2(x, y);
    }
  }

  double singlePerlinFractalFBM2(double x, double y) {
    var seed = baseNoise.seed;
    var sum = baseNoise.singlePerlin2(seed, x, y), amp = 1.0;

    for (var i = 1; i < octaves; i++) {
      x *= lacunarity;
      y *= lacunarity;

      amp *= gain;
      sum += baseNoise.singlePerlin2(++seed, x, y) * amp;
    }

    return sum * fractalBounding;
  }

  double singlePerlinFractalBillow2(double x, double y) {
    var seed = baseNoise.seed;
    var sum = baseNoise.singlePerlin2(seed, x, y).abs() * 2.0 - 1.0, amp = 1.0;

    for (var i = 1; i < octaves; i++) {
      x *= lacunarity;
      y *= lacunarity;

      amp *= gain;
      sum += (baseNoise.singlePerlin2(++seed, x, y).abs() * 2.0 - 1.0) * amp;
    }

    return sum * fractalBounding;
  }

  double singlePerlinFractalRigidMulti2(double x, double y) {
    var seed = baseNoise.seed;
    var sum = 1.0 - baseNoise.singlePerlin2(seed, x, y).abs(), amp = 1.0;

    for (var i = 1; i < octaves; i++) {
      x *= lacunarity;
      y *= lacunarity;

      amp *= gain;
      sum -= (1.0 - baseNoise.singlePerlin2(++seed, x, y).abs()) * amp;
    }

    return sum;
  }
}
