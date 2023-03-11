import 'package:fast_noise/fast_noise.dart';
import 'package:fast_noise/src/noise_factory.dart';

/// Creates 2D noise
List<List<double>> noise2(
  int width,
  int height, {
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
  final map = List<List<double>>.generate(
    width,
    (_) => List<double>.generate(height, (_) => .0),
  );

  final noise = buildNoise(
    seed: seed,
    frequency: frequency,
    interp: interp,
    noiseType: noiseType,
    octaves: octaves,
    lacunarity: lacunarity,
    gain: gain,
    fractalType: fractalType,
    cellularDistanceFunction: cellularDistanceFunction,
    cellularReturnType: cellularReturnType,
  );

  for (var x = 0; x < width; x++) {
    for (var y = 0; y < height; y++) {
      map[x][y] = noise.getNoise2(x.toDouble(), y.toDouble());
    }
  }

  return map;
}

/// Creates 3D noise
List<List<List<double>>> noise3(
  int width,
  int height,
  int depth, {
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
  final map = List<List<List<double>>>.generate(
    width,
    (_) => List<List<double>>.generate(
      height,
      (_) => List<double>.generate(depth, (_) => .0),
    ),
  );

  final noise = buildNoise(
    seed: seed,
    frequency: frequency,
    interp: interp,
    noiseType: noiseType,
    octaves: octaves,
    lacunarity: lacunarity,
    gain: gain,
    fractalType: fractalType,
    cellularDistanceFunction: cellularDistanceFunction,
    cellularReturnType: cellularReturnType,
  );

  for (var x = 0; x < width; x++) {
    for (var y = 0; y < height; y++) {
      for (var z = 0; z < height; z++) {
        noise.getNoise3(x.toDouble(), y.toDouble(), z.toDouble());
      }
    }
  }

  return map;
}
