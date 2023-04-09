import 'package:fast_noise/fast_noise.dart';

Noise2And3 buildNoise({
  int seed = 1337,
  double frequency = .01,
  Interp interp = Interp.quintic,
  NoiseType noiseType = NoiseType.simplex,
  int octaves = 3,
  double lacunarity = 2.0,
  double gain = .5,
  FractalType fractalType = FractalType.fbm,
  CellularDistanceFunction cellularDistanceFunction =
      CellularDistanceFunction.euclidean,
  CellularReturnType cellularReturnType = CellularReturnType.cellValue,
}) {
  switch (noiseType) {
    case NoiseType.cellular:
      return CellularNoise(
        seed: seed,
        frequency: frequency,
        cellularDistanceFunction: cellularDistanceFunction,
        cellularReturnType: cellularReturnType,
      );
    case NoiseType.cubic:
      return CubicNoise(
        seed: seed,
        frequency: frequency,
      );
    case NoiseType.cubicFractal:
      return CubicFractalNoise(
        seed: seed,
        frequency: frequency,
        fractalType: fractalType,
        octaves: octaves,
        gain: gain,
        lacunarity: lacunarity,
      );
    case NoiseType.perlin:
      return PerlinNoise(
        seed: seed,
        frequency: frequency,
        interp: interp,
      );
    case NoiseType.perlinFractal:
      return PerlinFractalNoise(
        seed: seed,
        frequency: frequency,
        interp: interp,
        fractalType: fractalType,
        octaves: octaves,
        gain: gain,
        lacunarity: lacunarity,
      );
    case NoiseType.simplex:
      return SimplexNoise(
        seed: seed,
        frequency: frequency,
      );
    case NoiseType.simplexFractal:
      return SimplexFractalNoise(
        seed: seed,
        frequency: frequency,
        fractalType: fractalType,
        octaves: octaves,
        gain: gain,
        lacunarity: lacunarity,
      );
    case NoiseType.value:
      return ValueNoise(
        seed: seed,
        frequency: frequency,
        interp: interp,
      );
    case NoiseType.valueFractal:
      return ValueFractalNoise(
        seed: seed,
        frequency: frequency,
        interp: interp,
        fractalType: fractalType,
        octaves: octaves,
        gain: gain,
        lacunarity: lacunarity,
      );
    case NoiseType.whiteNoise:
      return WhiteNoise(
        seed: seed,
      );
  }
}
