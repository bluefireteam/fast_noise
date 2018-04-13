enum NoiseType {
  Value,
  ValueFractal,
  Perlin,
  PerlinFractal,
  Simplex,
  SimplexFractal,
  Cellular,
  WhiteNoise,
  Cubic,
  CubicFractal
}

enum Interp { Linear, Hermite, Quintic }

enum FractalType { FBM, Billow, RigidMulti }

enum CellularDistanceFunction { Euclidean, Manhattan, Natural }

enum CellularReturnType {
  CellValue,
  Distance,
  Distance2,
  Distance2Add,
  Distance2Sub,
  Distance2Mul,
  Distance2Div
}
