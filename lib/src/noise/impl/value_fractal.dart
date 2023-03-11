import 'package:fast_noise/fast_noise.dart';

class ValueFractalNoise implements Noise2And3 {
  final ValueNoise baseNoise;
  final int octaves;
  final double lacunarity, gain;
  final FractalType fractalType;
  final double fractalBounding;

  ValueFractalNoise({
    int seed = 1337,
    double frequency = .01,
    Interp interp = Interp.Quintic,
    this.octaves = 3,
    this.lacunarity = 2.0,
    this.gain = .5,
    this.fractalType = FractalType.FBM,
  })  : baseNoise = ValueNoise(
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
        return singleValueFractalFBM3(x, y, z);
      case FractalType.Billow:
        return singleValueFractalBillow3(x, y, z);
      case FractalType.RigidMulti:
        return singleValueFractalRigidMulti3(x, y, z);
    }
  }

  double singleValueFractalFBM3(double x, double y, double z) {
    var seed = baseNoise.seed;
    var sum = baseNoise.singleValue3(seed, x, y, z), amp = 1.0;

    for (var i = 1; i < octaves; i++) {
      x *= lacunarity;
      y *= lacunarity;
      z *= lacunarity;

      amp *= gain;
      sum += baseNoise.singleValue3(++seed, x, y, z) * amp;
    }

    return sum * fractalBounding;
  }

  double singleValueFractalBillow3(double x, double y, double z) {
    var seed = baseNoise.seed;
    var sum = baseNoise.singleValue3(seed, x, y, z).abs() * 2.0 - 1.0,
        amp = 1.0;

    for (var i = 1; i < octaves; i++) {
      x *= lacunarity;
      y *= lacunarity;
      z *= lacunarity;

      amp *= gain;
      sum += (baseNoise.singleValue3(++seed, x, y, z).abs() * 2.0 - 1.0) * amp;
    }

    return sum * fractalBounding;
  }

  double singleValueFractalRigidMulti3(double x, double y, double z) {
    var seed = baseNoise.seed;
    var sum = 1.0 - baseNoise.singleValue3(seed, x, y, z).abs(), amp = 1.0;

    for (var i = 1; i < octaves; i++) {
      x *= lacunarity;
      y *= lacunarity;
      z *= lacunarity;

      amp *= gain;
      sum -= (1.0 - baseNoise.singleValue3(++seed, x, y, z).abs()) * amp;
    }

    return sum;
  }

  @override
  double getNoise2(double x, double y) {
    x *= baseNoise.frequency;
    y *= baseNoise.frequency;

    switch (fractalType) {
      case FractalType.FBM:
        return singleValueFractalFBM2(x, y);
      case FractalType.Billow:
        return singleValueFractalBillow2(x, y);
      case FractalType.RigidMulti:
        return singleValueFractalRigidMulti2(x, y);
    }
  }

  double singleValueFractalFBM2(double x, double y) {
    var seed = baseNoise.seed;
    var sum = baseNoise.singleValue2(seed, x, y), amp = 1.0;

    for (var i = 1; i < octaves; i++) {
      x *= lacunarity;
      y *= lacunarity;

      amp *= gain;
      sum += baseNoise.singleValue2(++seed, x, y) * amp;
    }

    return sum * fractalBounding;
  }

  double singleValueFractalBillow2(double x, double y) {
    var seed = baseNoise.seed;
    var sum = baseNoise.singleValue2(seed, x, y).abs() * 2.0 - 1.0, amp = 1.0;

    for (var i = 1; i < octaves; i++) {
      x *= lacunarity;
      y *= lacunarity;
      amp *= gain;
      sum += (baseNoise.singleValue2(++seed, x, y).abs() * 2.0 - 1.0) * amp;
    }

    return sum * fractalBounding;
  }

  double singleValueFractalRigidMulti2(double x, double y) {
    var seed = baseNoise.seed;
    var sum = 1.0 - baseNoise.singleValue2(seed, x, y).abs(), amp = 1.0;

    for (var i = 1; i < octaves; i++) {
      x *= lacunarity;
      y *= lacunarity;

      amp *= gain;
      sum -= (1.0 - baseNoise.singleValue2(++seed, x, y).abs()) * amp;
    }

    return sum;
  }
}
