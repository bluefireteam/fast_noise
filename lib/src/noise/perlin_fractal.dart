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
    final dx = x * baseNoise.frequency;
    final dy = y * baseNoise.frequency;
    final dz = z * baseNoise.frequency;

    switch (fractalType) {
      case FractalType.FBM:
        return singlePerlinFractalFBM3(dx, dy, dz);
      case FractalType.Billow:
        return singlePerlinFractalBillow3(dx, dy, dz);
      case FractalType.RigidMulti:
        return singlePerlinFractalRigidMulti3(dx, dy, dz);
    }
  }

  double singlePerlinFractalFBM3(double x, double y, double z) {
    var seed = baseNoise.seed;
    var dx = x, dy = y, dz = z;
    var sum = baseNoise.singlePerlin3(seed, dx, dy, dz), amp = 1.0;

    for (var i = 1; i < octaves; i++) {
      dx *= lacunarity;
      dy *= lacunarity;
      dz *= lacunarity;

      amp *= gain;
      sum += baseNoise.singlePerlin3(++seed, dx, dy, dz) * amp;
    }

    return sum * fractalBounding;
  }

  double singlePerlinFractalBillow3(double x, double y, double z) {
    var seed = baseNoise.seed;
    var dx = x, dy = y, dz = z;
    var sum = baseNoise.singlePerlin3(seed, dx, dy, dz).abs() * 2.0 - 1.0,
        amp = 1.0;

    for (var i = 1; i < octaves; i++) {
      dx *= lacunarity;
      dy *= lacunarity;
      dz *= lacunarity;

      amp *= gain;
      sum +=
          (baseNoise.singlePerlin3(++seed, dx, dy, dz).abs() * 2.0 - 1.0) * amp;
    }

    return sum * fractalBounding;
  }

  double singlePerlinFractalRigidMulti3(double x, double y, double z) {
    var seed = baseNoise.seed;
    var dx = x, dy = y, dz = z;
    var sum = 1.0 - baseNoise.singlePerlin3(seed, dx, dy, dz).abs(), amp = 1.0;

    for (var i = 1; i < octaves; i++) {
      dx *= lacunarity;
      dy *= lacunarity;
      dz *= lacunarity;

      amp *= gain;
      sum -= (1.0 - baseNoise.singlePerlin3(++seed, dx, dy, dz).abs()) * amp;
    }

    return sum;
  }

  @override
  double getNoise2(double x, double y) {
    final dx = x * baseNoise.frequency;
    final dy = y * baseNoise.frequency;

    switch (fractalType) {
      case FractalType.FBM:
        return singlePerlinFractalFBM2(dx, dy);
      case FractalType.Billow:
        return singlePerlinFractalBillow2(dx, dy);
      case FractalType.RigidMulti:
        return singlePerlinFractalRigidMulti2(dx, dy);
    }
  }

  double singlePerlinFractalFBM2(double x, double y) {
    var seed = baseNoise.seed;
    var dx = x, dy = y;
    var sum = baseNoise.singlePerlin2(seed, dx, dy), amp = 1.0;

    for (var i = 1; i < octaves; i++) {
      dx *= lacunarity;
      dy *= lacunarity;

      amp *= gain;
      sum += baseNoise.singlePerlin2(++seed, dx, dy) * amp;
    }

    return sum * fractalBounding;
  }

  double singlePerlinFractalBillow2(double x, double y) {
    var seed = baseNoise.seed;
    var dx = x, dy = y;
    var sum = baseNoise.singlePerlin2(seed, dx, dy).abs() * 2.0 - 1.0,
        amp = 1.0;

    for (var i = 1; i < octaves; i++) {
      dx *= lacunarity;
      dy *= lacunarity;

      amp *= gain;
      sum += (baseNoise.singlePerlin2(++seed, dx, dy).abs() * 2.0 - 1.0) * amp;
    }

    return sum * fractalBounding;
  }

  double singlePerlinFractalRigidMulti2(double x, double y) {
    var seed = baseNoise.seed;
    var dx = x, dy = y;
    var sum = 1.0 - baseNoise.singlePerlin2(seed, dx, dy).abs(), amp = 1.0;

    for (var i = 1; i < octaves; i++) {
      dx *= lacunarity;
      dy *= lacunarity;

      amp *= gain;
      sum -= (1.0 - baseNoise.singlePerlin2(++seed, dx, dy).abs()) * amp;
    }

    return sum;
  }
}
