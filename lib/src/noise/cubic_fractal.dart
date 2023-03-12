import 'package:fast_noise/fast_noise.dart';

class CubicFractalNoise implements Noise2And3 {
  final CubicNoise baseNoise;

  final FractalType fractalType;
  final int octaves;
  final double gain;
  final double lacunarity;
  final double fractalBounding;

  CubicFractalNoise({
    int seed = 1337,
    double frequency = .01,
    this.fractalType = FractalType.fbm,
    this.octaves = 3,
    this.gain = .5,
    this.lacunarity = 2.0,
  })  : baseNoise = CubicNoise(
          seed: seed,
          frequency: frequency,
        ),
        fractalBounding = calculateFractalBounding(octaves, gain);

  @override
  double getNoise3(double x, double y, double z) {
    final dx = x * baseNoise.frequency;
    final dy = y * baseNoise.frequency;
    final dz = z * baseNoise.frequency;

    switch (fractalType) {
      case FractalType.fbm:
        return singleCubicFractalFBM3(dx, dy, dz);
      case FractalType.billow:
        return singleCubicFractalBillow3(dx, dy, dz);
      case FractalType.rigidMulti:
        return singleCubicFractalRigidMulti3(dx, dy, dz);
    }
  }

  double singleCubicFractalFBM3(double x, double y, double z) {
    var seed = baseNoise.seed, i = 0;
    var dx = x, dy = y, dz = z;
    var sum = baseNoise.singleCubic3(seed, dx, dy, dz), amp = 1.0;

    while (++i < octaves) {
      dx *= lacunarity;
      dy *= lacunarity;
      dz *= lacunarity;

      amp *= gain;
      sum += baseNoise.singleCubic3(++seed, dx, dy, dz) * amp;
    }

    return sum * fractalBounding;
  }

  double singleCubicFractalBillow3(double x, double y, double z) {
    var seed = baseNoise.seed, i = 0;
    var dx = x, dy = y, dz = z;
    var sum = baseNoise.singleCubic3(seed, dx, dy, dz).abs() * 2 - 1, amp = 1.0;

    while (++i < octaves) {
      dx *= lacunarity;
      dy *= lacunarity;
      dz *= lacunarity;

      amp *= gain;
      sum +=
          (baseNoise.singleCubic3(++seed, dx, dy, dz).abs() * 2.0 - 1.0) * amp;
    }

    return sum * fractalBounding;
  }

  double singleCubicFractalRigidMulti3(double x, double y, double z) {
    var seed = baseNoise.seed, i = 0;
    var dx = x, dy = y, dz = z;
    var sum = 1.0 - baseNoise.singleCubic3(seed, dx, dy, dz).abs(), amp = 1.0;

    while (++i < octaves) {
      dx *= lacunarity;
      dy *= lacunarity;
      dz *= lacunarity;

      amp *= gain;
      sum -= (1.0 - baseNoise.singleCubic3(++seed, dx, dy, dz).abs()) * amp;
    }

    return sum;
  }

  @override
  double getNoise2(double x, double y) {
    final dx = x * baseNoise.frequency;
    final dy = y * baseNoise.frequency;

    switch (fractalType) {
      case FractalType.fbm:
        return singleCubicFractalFBM2(dx, dy);
      case FractalType.billow:
        return singleCubicFractalBillow2(dx, dy);
      case FractalType.rigidMulti:
        return singleCubicFractalRigidMulti2(dx, dy);
    }
  }

  double singleCubicFractalFBM2(double x, double y) {
    var seed = baseNoise.seed, i = 0;
    var dx = x, dy = y;
    var sum = baseNoise.singleCubic2(seed, dx, dy), amp = 1.0;

    while (++i < octaves) {
      dx *= lacunarity;
      dy *= lacunarity;

      amp *= gain;
      sum += baseNoise.singleCubic2(++seed, dx, dy) * amp;
    }

    return sum * fractalBounding;
  }

  double singleCubicFractalBillow2(double x, double y) {
    var seed = baseNoise.seed, i = 0;
    var dx = x, dy = y;
    var sum = baseNoise.singleCubic2(seed, dx, dy).abs() * 2.0 - 1.0, amp = 1.0;

    while (++i < octaves) {
      dx *= lacunarity;
      dy *= lacunarity;

      amp *= gain;
      sum += (baseNoise.singleCubic2(++seed, dx, dy).abs() * 2.0 - 1.0) * amp;
    }

    return sum * fractalBounding;
  }

  double singleCubicFractalRigidMulti2(double x, double y) {
    var seed = baseNoise.seed, i = 0;
    var dx = x, dy = y;
    var sum = 1 - baseNoise.singleCubic2(seed, dx, dy).abs(), amp = 1.0;

    while (++i < octaves) {
      dx *= lacunarity;
      dy *= lacunarity;

      amp *= gain;
      sum -= (1.0 - baseNoise.singleCubic2(++seed, dx, dy).abs()) * amp;
    }

    return sum;
  }
}
