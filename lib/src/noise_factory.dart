import 'package:fast_noise/fast_noise.dart';

Noise2And3 buildNoise({
  final int seed = 1337,
  final double frequency = .01,
  final Interp interp = Interp.Quintic,
  final NoiseType noiseType = NoiseType.Simplex,
  final int octaves = 3,
  final double lacunarity = 2.0,
  final double gain = .5,
  final FractalType fractalType = FractalType.FBM,
  final CellularDistanceFunction cellularDistanceFunction =
      CellularDistanceFunction.Euclidean,
  final CellularReturnType cellularReturnType = CellularReturnType.CellValue,
}) {
  switch (noiseType) {
    case NoiseType.Cellular:
      return CellularNoise(
        seed: seed,
        frequency: frequency,
        cellularDistanceFunction: cellularDistanceFunction,
        cellularReturnType: cellularReturnType,
      );
    case NoiseType.Cubic:
      return CubicNoise(
        seed: seed,
        frequency: frequency,
      );
    case NoiseType.CubicFractal:
      return CubicFractalNoise(
        seed: seed,
        frequency: frequency,
        fractalType: fractalType,
        octaves: octaves,
        gain: gain,
        lacunarity: lacunarity,
      );
    case NoiseType.Perlin:
      return PerlinNoise(
        seed: seed,
        frequency: frequency,
        interp: interp,
      );
    case NoiseType.PerlinFractal:
      return PerlinFractalNoise(
        seed: seed,
        frequency: frequency,
        interp: interp,
        fractalType: fractalType,
        octaves: octaves,
        gain: gain,
        lacunarity: lacunarity,
      );
    case NoiseType.Simplex:
      return SimplexNoise(
        seed: seed,
        frequency: frequency,
      );
    case NoiseType.SimplexFractal:
      return SimplexFractalNoise(
        seed: seed,
        frequency: frequency,
        fractalType: fractalType,
        octaves: octaves,
        gain: gain,
        lacunarity: lacunarity,
      );
    case NoiseType.Value:
      return ValueNoise(
        seed: seed,
        frequency: frequency,
        interp: interp,
      );
    case NoiseType.ValueFractal:
      return ValueFractalNoise(
        seed: seed,
        frequency: frequency,
        interp: interp,
        fractalType: fractalType,
        octaves: octaves,
        gain: gain,
        lacunarity: lacunarity,
      );
    case NoiseType.WhiteNoise:
      return WhiteNoise(
        seed: seed,
      );
  }
}
