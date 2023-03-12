import 'package:fast_noise/fast_noise.dart';

class ValueFractalNoise implements Noise2And3 {
  final ValueNoise baseNoise;

  final FractalType fractalType;
  final int octaves;
  final double gain;
  final double lacunarity;
  final double fractalBounding;

  ValueFractalNoise({
    int seed = 1337,
    double frequency = .01,
    Interp interp = Interp.Quintic,
    this.fractalType = FractalType.FBM,
    this.octaves = 3,
    this.gain = .5,
    this.lacunarity = 2.0,
  })  : baseNoise = ValueNoise(
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
        return singleValueFractalFBM3(dx, dy, dz);
      case FractalType.Billow:
        return singleValueFractalBillow3(dx, dy, dz);
      case FractalType.RigidMulti:
        return singleValueFractalRigidMulti3(dx, dy, dz);
    }
  }

  double singleValueFractalFBM3(double x, double y, double z) {
    var seed = baseNoise.seed;
    var dx = x, dy = y, dz = z;
    var sum = baseNoise.singleValue3(seed, dx, dy, dz), amp = 1.0;

    for (var i = 1; i < octaves; i++) {
      dx *= lacunarity;
      dy *= lacunarity;
      dz *= lacunarity;

      amp *= gain;
      sum += baseNoise.singleValue3(++seed, dx, dy, dz) * amp;
    }

    return sum * fractalBounding;
  }

  double singleValueFractalBillow3(double x, double y, double z) {
    var seed = baseNoise.seed;
    var dx = x, dy = y, dz = z;
    var sum = baseNoise.singleValue3(seed, dx, dy, dz).abs() * 2.0 - 1.0,
        amp = 1.0;

    for (var i = 1; i < octaves; i++) {
      dx *= lacunarity;
      dy *= lacunarity;
      dz *= lacunarity;

      amp *= gain;
      sum +=
          (baseNoise.singleValue3(++seed, dx, dy, dz).abs() * 2.0 - 1.0) * amp;
    }

    return sum * fractalBounding;
  }

  double singleValueFractalRigidMulti3(double x, double y, double z) {
    var seed = baseNoise.seed;
    var dx = x, dy = y, dz = z;
    var sum = 1.0 - baseNoise.singleValue3(seed, dx, dy, dz).abs(), amp = 1.0;

    for (var i = 1; i < octaves; i++) {
      dx *= lacunarity;
      dy *= lacunarity;
      dz *= lacunarity;

      amp *= gain;
      sum -= (1.0 - baseNoise.singleValue3(++seed, dx, dy, dz).abs()) * amp;
    }

    return sum;
  }

  @override
  double getNoise2(double x, double y) {
    final dx = x * baseNoise.frequency;
    final dy = y * baseNoise.frequency;

    switch (fractalType) {
      case FractalType.FBM:
        return singleValueFractalFBM2(dx, dy);
      case FractalType.Billow:
        return singleValueFractalBillow2(dx, dy);
      case FractalType.RigidMulti:
        return singleValueFractalRigidMulti2(dx, dy);
    }
  }

  double singleValueFractalFBM2(double x, double y) {
    var seed = baseNoise.seed;
    var dx = x, dy = y;
    var sum = baseNoise.singleValue2(seed, dx, dy), amp = 1.0;

    for (var i = 1; i < octaves; i++) {
      dx *= lacunarity;
      dy *= lacunarity;

      amp *= gain;
      sum += baseNoise.singleValue2(++seed, dx, dy) * amp;
    }

    return sum * fractalBounding;
  }

  double singleValueFractalBillow2(double x, double y) {
    var seed = baseNoise.seed;
    var dx = x, dy = y;
    var sum = baseNoise.singleValue2(seed, dx, dy).abs() * 2.0 - 1.0, amp = 1.0;

    for (var i = 1; i < octaves; i++) {
      dx *= lacunarity;
      dy *= lacunarity;
      amp *= gain;
      sum += (baseNoise.singleValue2(++seed, dx, dy).abs() * 2.0 - 1.0) * amp;
    }

    return sum * fractalBounding;
  }

  double singleValueFractalRigidMulti2(double x, double y) {
    var seed = baseNoise.seed;
    var dx = x, dy = y;
    var sum = 1.0 - baseNoise.singleValue2(seed, dx, dy).abs(), amp = 1.0;

    for (var i = 1; i < octaves; i++) {
      dx *= lacunarity;
      dy *= lacunarity;

      amp *= gain;
      sum -= (1.0 - baseNoise.singleValue2(++seed, dx, dy).abs()) * amp;
    }

    return sum;
  }
}
