import 'package:fast_noise/fast_noise.dart';
import 'package:fast_noise/src/noise/noise.dart';
import 'package:fast_noise/src/utils.dart';

class CubicFractalNoise implements Noise2And3 {
  final CubicNoise baseNoise;
  final FractalType fractalType;
  final int octaves;
  final double lacunarity;
  final double gain;
  final double fractalBounding;

  CubicFractalNoise({
    int seed = 1337,
    double frequency = .01,
    Interp interp = Interp.Quintic,
    this.octaves = 3,
    this.lacunarity = 2.0,
    this.gain = .5,
    this.fractalType = FractalType.FBM,
  })  : baseNoise = CubicNoise(
          seed: seed,
          frequency: frequency,
          interp: interp,
        ),
        fractalBounding = calculateFractalBounding(gain, octaves);

  @override
  double getNoise3(double x, double y, double z) {
    x *= baseNoise.frequency;
    y *= baseNoise.frequency;
    z *= baseNoise.frequency;

    switch (fractalType) {
      case FractalType.FBM:
        return singleCubicFractalFBM3(x, y, z);
      case FractalType.Billow:
        return singleCubicFractalBillow3(x, y, z);
      case FractalType.RigidMulti:
        return singleCubicFractalRigidMulti3(x, y, z);
    }
  }

  double singleCubicFractalFBM3(double x, double y, double z) {
    var seed = baseNoise.seed, i = 0;
    var sum = baseNoise.singleCubic3(seed, x, y, z), amp = 1.0;

    while (++i < octaves) {
      x *= lacunarity;
      y *= lacunarity;
      z *= lacunarity;

      amp *= gain;
      sum += baseNoise.singleCubic3(++seed, x, y, z) * amp;
    }

    return sum * fractalBounding;
  }

  double singleCubicFractalBillow3(double x, double y, double z) {
    var seed = baseNoise.seed, i = 0;
    var sum = baseNoise.singleCubic3(seed, x, y, z).abs() * 2 - 1, amp = 1.0;

    while (++i < octaves) {
      x *= lacunarity;
      y *= lacunarity;
      z *= lacunarity;

      amp *= gain;
      sum += (baseNoise.singleCubic3(++seed, x, y, z).abs() * 2.0 - 1.0) * amp;
    }

    return sum * fractalBounding;
  }

  double singleCubicFractalRigidMulti3(double x, double y, double z) {
    var seed = baseNoise.seed, i = 0;
    var sum = 1.0 - baseNoise.singleCubic3(seed, x, y, z).abs(), amp = 1.0;

    while (++i < octaves) {
      x *= lacunarity;
      y *= lacunarity;
      z *= lacunarity;

      amp *= gain;
      sum -= (1.0 - baseNoise.singleCubic3(++seed, x, y, z).abs()) * amp;
    }

    return sum;
  }

  @override
  double getNoise2(double x, double y) {
    x *= baseNoise.frequency;
    y *= baseNoise.frequency;

    switch (fractalType) {
      case FractalType.FBM:
        return singleCubicFractalFBM2(x, y);
      case FractalType.Billow:
        return singleCubicFractalBillow2(x, y);
      case FractalType.RigidMulti:
        return singleCubicFractalRigidMulti2(x, y);
    }
  }

  double singleCubicFractalFBM2(double x, double y) {
    var seed = baseNoise.seed, i = 0;
    var sum = baseNoise.singleCubic2(seed, x, y), amp = 1.0;

    while (++i < octaves) {
      x *= lacunarity;
      y *= lacunarity;

      amp *= gain;
      sum += baseNoise.singleCubic2(++seed, x, y) * amp;
    }

    return sum * fractalBounding;
  }

  double singleCubicFractalBillow2(double x, double y) {
    var seed = baseNoise.seed, i = 0;
    var sum = baseNoise.singleCubic2(seed, x, y).abs() * 2.0 - 1.0, amp = 1.0;

    while (++i < octaves) {
      x *= lacunarity;
      y *= lacunarity;

      amp *= gain;
      sum += (baseNoise.singleCubic2(++seed, x, y).abs() * 2.0 - 1.0) * amp;
    }

    return sum * fractalBounding;
  }

  double singleCubicFractalRigidMulti2(double x, double y) {
    var seed = baseNoise.seed, i = 0;
    var sum = 1 - baseNoise.singleCubic2(seed, x, y).abs(), amp = 1.0;

    while (++i < octaves) {
      x *= lacunarity;
      y *= lacunarity;

      amp *= gain;
      sum -= (1.0 - baseNoise.singleCubic2(++seed, x, y).abs()) * amp;
    }

    return sum;
  }
}