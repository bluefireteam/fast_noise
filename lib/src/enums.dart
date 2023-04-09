enum NoiseType {
  cellular,
  cubic,
  cubicFractal,
  perlin,
  perlinFractal,
  simplex,
  simplexFractal,
  value,
  valueFractal,
  whiteNoise,
}

enum Interp { linear, hermite, quintic }

enum FractalType { fbm, billow, rigidMulti }

enum CellularDistanceFunction { euclidean, manhattan, natural }

enum CellularReturnType {
  cellValue,
  distance,
  distance2,
  distance2Add,
  distance2Sub,
  distance2Mul,
  distance2Div
}
