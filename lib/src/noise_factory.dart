import 'package:fast_noise/src/noise/noise.dart';

import '../fast_noise.dart';
import 'noise/cubic_fractal.dart';
import 'noise/perlin_fractal.dart';
import 'noise/simplex_fractal.dart';
import 'noise/value_fractal.dart';

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
        cellularDistanceFunction: cellularDistanceFunction,
        cellularReturnType: cellularReturnType,
        frequency: frequency,
        gain: gain,
        interp: interp,
        lacunarity: lacunarity,
        octaves: octaves,
        seed: seed,
      );
    case NoiseType.Cubic:
      return CubicNoise(
        frequency: frequency,
        interp: interp,
        seed: seed,
      );
    case NoiseType.CubicFractal:
      return CubicFractalNoise(
        fractalType: fractalType,
        frequency: frequency,
        gain: gain,
        interp: interp,
        lacunarity: lacunarity,
        octaves: octaves,
        seed: seed,
      );
    case NoiseType.Perlin:
      return PerlinNoise(
        frequency: frequency,
        interp: interp,
        seed: seed,
      );
    case NoiseType.PerlinFractal:
      return PerlinFractalNoise(
        fractalType: fractalType,
        frequency: frequency,
        gain: gain,
        interp: interp,
        lacunarity: lacunarity,
        octaves: octaves,
        seed: seed,
      );
    case NoiseType.Simplex:
      return SimplexNoise(
        frequency: frequency,
        gain: gain,
        interp: interp,
        lacunarity: lacunarity,
        octaves: octaves,
        seed: seed,
      );
    case NoiseType.SimplexFractal:
      return SimplexFractalNoise(
        fractalType: fractalType,
        frequency: frequency,
        gain: gain,
        interp: interp,
        lacunarity: lacunarity,
        octaves: octaves,
        seed: seed,
      );
    case NoiseType.Value:
      return ValueNoise(
        frequency: frequency,
        interp: interp,
        seed: seed,
      );
    case NoiseType.ValueFractal:
      return ValueFractalNoise(
        fractalType: fractalType,
        frequency: frequency,
        gain: gain,
        interp: interp,
        lacunarity: lacunarity,
        octaves: octaves,
        seed: seed,
      );
    case NoiseType.WhiteNoise:
      return WhiteNoise(seed: seed);
  }
}
