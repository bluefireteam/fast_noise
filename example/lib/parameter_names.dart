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
  NoiseType.cellular: {
    ParameterNames.cellularDistanceFunction,
    ParameterNames.cellularReturnType,
  },
  NoiseType.cubic: {},
  NoiseType.cubicFractal: _fractalParameters,
  NoiseType.perlin: {ParameterNames.interp},
  NoiseType.perlinFractal: {ParameterNames.interp, ..._fractalParameters},
  NoiseType.simplex: {},
  NoiseType.simplexFractal: _fractalParameters,
  NoiseType.value: {ParameterNames.interp},
  NoiseType.valueFractal: {ParameterNames.interp, ..._fractalParameters},
  NoiseType.whiteNoise: {},
};
