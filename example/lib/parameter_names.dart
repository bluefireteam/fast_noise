import 'package:fast_noise/fast_noise.dart';

enum ParameterNames {
  interp,
  fractalType,
  octaves,
  gain,
  lacunarity,
  cellularDistanceFunction,
  cellularReturnType,
}

final _fractalParameters = {
  ParameterNames.fractalType,
  ParameterNames.octaves,
  ParameterNames.gain,
  ParameterNames.lacunarity,
};

final Map<NoiseType, Set<ParameterNames>> parametersPerNoiseType = {
  NoiseType.Cellular: {
    ParameterNames.cellularDistanceFunction,
    ParameterNames.cellularReturnType,
  },
  NoiseType.Cubic: {},
  NoiseType.CubicFractal: _fractalParameters,
  NoiseType.Perlin: {ParameterNames.interp},
  NoiseType.PerlinFractal: {ParameterNames.interp, ..._fractalParameters},
  NoiseType.Simplex: {},
  NoiseType.SimplexFractal: _fractalParameters,
  NoiseType.Value: {ParameterNames.interp},
  NoiseType.ValueFractal: {ParameterNames.interp, ..._fractalParameters},
  NoiseType.WhiteNoise: {},
};
