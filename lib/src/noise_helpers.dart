import 'package:fast_noise/fast_noise.dart';

/// Creates 2D noise
List<List<double>> noise2(
  int width,
  int height, {
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

  return List<List<double>>.generate(
    width,
    (x) => List<double>.generate(
      height,
      (y) => noise.getNoise2(x.toDouble(), y.toDouble()),
    ),
  );
}

/// Creates 3D noise
List<List<List<double>>> noise3(
  int width,
  int height,
  int depth, {
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

  return List<List<List<double>>>.generate(
    width,
    (x) => List<List<double>>.generate(
      height,
      (y) => List<double>.generate(
        depth,
        (z) => noise.getNoise3(x.toDouble(), y.toDouble(), z.toDouble()),
      ),
    ),
  );
}
