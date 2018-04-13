library fast_noise;

import 'package:fast_noise/src/noise/enums.dart'
    show
        CellularDistanceFunction,
        CellularReturnType,
        FractalType,
        Interp,
        NoiseType;

import 'package:fast_noise/src/noise/cellular.dart' show CellularNoise;
import 'package:fast_noise/src/noise/cubic.dart' show CubicNoise;
import 'package:fast_noise/src/noise/perlin.dart' show PerlinNoise;
import 'package:fast_noise/src/noise/simplex.dart' show SimplexNoise;
import 'package:fast_noise/src/noise/value.dart' show ValueNoise;
import 'package:fast_noise/src/noise/white.dart' show WhiteNoise;

export 'package:fast_noise/src/noise/enums.dart';

export 'package:fast_noise/src/noise/cellular.dart' show CellularNoise;
export 'package:fast_noise/src/noise/cubic.dart' show CubicNoise;
export 'package:fast_noise/src/noise/perlin.dart' show PerlinNoise;
export 'package:fast_noise/src/noise/simplex.dart' show SimplexNoise;
export 'package:fast_noise/src/noise/value.dart' show ValueNoise;
export 'package:fast_noise/src/noise/white.dart' show WhiteNoise;

List<List<double>> noise2(int width, int height,
    {final int seed: 1337,
    final double frequency: .01,
    final Interp interp: Interp.Quintic,
    final NoiseType noiseType: NoiseType.Simplex,
    final int octaves: 3,
    final double lacunarity: 2.0,
    final double gain: .5,
    final FractalType fractalType: FractalType.FBM,
    final CellularDistanceFunction cellularDistanceFunction:
        CellularDistanceFunction.Euclidean,
    final CellularReturnType cellularReturnType:
        CellularReturnType.CellValue}) {
  final map = new List<List<double>>.generate(
      width, (_) => new List<double>.generate(height, (_) => .0));

  switch (noiseType) {
    case NoiseType.Cellular:
      final noise = new CellularNoise(
          cellularDistanceFunction: cellularDistanceFunction,
          cellularReturnType: cellularReturnType,
          fractalType: fractalType,
          frequency: frequency,
          gain: gain,
          interp: interp,
          lacunarity: lacunarity,
          octaves: octaves,
          seed: seed);

      for (int x = 0; x < width; x++) {
        for (int y = 0; y < height; y++) {
          double dx = x * frequency, dy = y * frequency;

          switch (cellularReturnType) {
            case CellularReturnType.CellValue:
            case CellularReturnType.Distance:
              map[x][y] = noise.singleCellular2(dx, dy);
              break;
            default:
              map[x][y] = noise.singleCellular2Edge2(dx, dy);
              break;
          }
        }
      }

      return map;

    case NoiseType.Cubic:
      final noise = new CubicNoise(
          cellularReturnType: cellularReturnType,
          fractalType: fractalType,
          frequency: frequency,
          gain: gain,
          interp: interp,
          lacunarity: lacunarity,
          octaves: octaves,
          seed: seed);

      for (int x = 0; x < width; x++) {
        for (int y = 0; y < height; y++) {
          double dx = x * frequency, dy = y * frequency;

          map[x][y] = noise.singleCubic2(seed, dx, dy);
        }
      }

      return map;

    case NoiseType.CubicFractal:
      final noise = new CubicNoise(
          cellularReturnType: cellularReturnType,
          fractalType: fractalType,
          frequency: frequency,
          gain: gain,
          interp: interp,
          lacunarity: lacunarity,
          octaves: octaves,
          seed: seed);

      for (int x = 0; x < width; x++) {
        for (int y = 0; y < height; y++) {
          double dx = x * frequency, dy = y * frequency;

          switch (fractalType) {
            case FractalType.FBM:
              map[x][y] = noise.singleCubicFractalFBM2(dx, dy);
              break;
            case FractalType.Billow:
              map[x][y] = noise.singleCubicFractalBillow2(dx, dy);
              break;
            case FractalType.RigidMulti:
              map[x][y] = noise.singleCubicFractalRigidMulti2(dx, dy);
              break;
          }
        }
      }

      return map;

    case NoiseType.Perlin:
      final noise = new PerlinNoise(
          cellularReturnType: cellularReturnType,
          fractalType: fractalType,
          frequency: frequency,
          gain: gain,
          interp: interp,
          lacunarity: lacunarity,
          octaves: octaves,
          seed: seed);

      for (int x = 0; x < width; x++) {
        for (int y = 0; y < height; y++) {
          double dx = x * frequency, dy = y * frequency;

          map[x][y] = noise.singlePerlin2(seed, dx, dy);
        }
      }

      return map;

    case NoiseType.PerlinFractal:
      final noise = new PerlinNoise(
          cellularReturnType: cellularReturnType,
          fractalType: fractalType,
          frequency: frequency,
          gain: gain,
          interp: interp,
          lacunarity: lacunarity,
          octaves: octaves,
          seed: seed);

      for (int x = 0; x < width; x++) {
        for (int y = 0; y < height; y++) {
          double dx = x * frequency, dy = y * frequency;

          switch (fractalType) {
            case FractalType.FBM:
              map[x][y] = noise.singlePerlinFractalFBM2(dx, dy);
              break;
            case FractalType.Billow:
              map[x][y] = noise.singlePerlinFractalBillow2(dx, dy);
              break;
            case FractalType.RigidMulti:
              map[x][y] = noise.singlePerlinFractalRigidMulti2(dx, dy);
              break;
          }
        }
      }

      return map;

    case NoiseType.Simplex:
      final noise = new SimplexNoise(
          cellularReturnType: cellularReturnType,
          fractalType: fractalType,
          frequency: frequency,
          gain: gain,
          interp: interp,
          lacunarity: lacunarity,
          octaves: octaves,
          seed: seed);

      for (int x = 0; x < width; x++) {
        for (int y = 0; y < height; y++) {
          double dx = x * frequency, dy = y * frequency;

          map[x][y] = noise.singleSimplex2(seed, dx, dy);
        }
      }

      return map;

    case NoiseType.SimplexFractal:
      final noise = new SimplexNoise(
          cellularReturnType: cellularReturnType,
          fractalType: fractalType,
          frequency: frequency,
          gain: gain,
          interp: interp,
          lacunarity: lacunarity,
          octaves: octaves,
          seed: seed);

      for (int x = 0; x < width; x++) {
        for (int y = 0; y < height; y++) {
          double dx = x * frequency, dy = y * frequency;

          switch (fractalType) {
            case FractalType.FBM:
              map[x][y] = noise.singleSimplexFractalFBM2(dx, dy);
              break;
            case FractalType.Billow:
              map[x][y] = noise.singleSimplexFractalBillow2(dx, dy);
              break;
            case FractalType.RigidMulti:
              map[x][y] = noise.singleSimplexFractalRigidMulti2(dx, dy);
              break;
          }
        }
      }

      return map;

    case NoiseType.Value:
      final noise = new ValueNoise(
          cellularReturnType: cellularReturnType,
          fractalType: fractalType,
          frequency: frequency,
          gain: gain,
          interp: interp,
          lacunarity: lacunarity,
          octaves: octaves,
          seed: seed);

      for (int x = 0; x < width; x++) {
        for (int y = 0; y < height; y++) {
          double dx = x * frequency, dy = y * frequency;

          map[x][y] = noise.singleValue2(seed, dx, dy);
        }
      }

      return map;

    case NoiseType.ValueFractal:
      final noise = new ValueNoise(
          cellularReturnType: cellularReturnType,
          fractalType: fractalType,
          frequency: frequency,
          gain: gain,
          interp: interp,
          lacunarity: lacunarity,
          octaves: octaves,
          seed: seed);

      for (int x = 0; x < width; x++) {
        for (int y = 0; y < height; y++) {
          double dx = x * frequency, dy = y * frequency;

          switch (fractalType) {
            case FractalType.FBM:
              map[x][y] = noise.singleValueFractalFBM2(dx, dy);
              break;
            case FractalType.Billow:
              map[x][y] = noise.singleValueFractalBillow2(dx, dy);
              break;
            case FractalType.RigidMulti:
              map[x][y] = noise.singleValueFractalRigidMulti2(dx, dy);
              break;
          }
        }
      }

      return map;

    case NoiseType.WhiteNoise:
      final noise = new WhiteNoise(seed: seed);

      for (int x = 0; x < width; x++) {
        for (int y = 0; y < height; y++) {
          double dx = x * frequency, dy = y * frequency;

          map[x][y] = noise.getWhiteNoise2(dx, dy);
        }
      }

      return map;
  }

  return map;
}

List<List<List<double>>> noise3(int width, int height, int depth,
    {final int seed: 1337,
    final double frequency: .01,
    final Interp interp: Interp.Quintic,
    final NoiseType noiseType: NoiseType.Simplex,
    final int octaves: 3,
    final double lacunarity: 2.0,
    final double gain: .5,
    final FractalType fractalType: FractalType.FBM,
    final CellularDistanceFunction cellularDistanceFunction:
        CellularDistanceFunction.Euclidean,
    final CellularReturnType cellularReturnType:
        CellularReturnType.CellValue}) {
  final map = new List<List<List<double>>>.generate(
      width,
      (_) => new List<List<double>>.generate(
          height, (_) => new List<double>.generate(depth, (_) => .0)));

  switch (noiseType) {
    case NoiseType.Cellular:
      final noise = new CellularNoise(
          cellularDistanceFunction: cellularDistanceFunction,
          cellularReturnType: cellularReturnType,
          fractalType: fractalType,
          frequency: frequency,
          gain: gain,
          interp: interp,
          lacunarity: lacunarity,
          octaves: octaves,
          seed: seed);

      for (int x = 0; x < width; x++) {
        for (int y = 0; y < height; y++) {
          for (int z = 0; z < height; z++) {
            double dx = x * frequency, dy = y * frequency, dz = z * frequency;

            switch (cellularReturnType) {
              case CellularReturnType.CellValue:
              case CellularReturnType.Distance:
                map[x][y][z] = noise.singleCellular3(dx, dy, dz);
                break;
              default:
                map[x][y][z] = noise.singleCellular2Edge3(dx, dy, dz);
                break;
            }
          }
        }
      }

      return map;

    case NoiseType.Cubic:
      final noise = new CubicNoise(
          cellularReturnType: cellularReturnType,
          fractalType: fractalType,
          frequency: frequency,
          gain: gain,
          interp: interp,
          lacunarity: lacunarity,
          octaves: octaves,
          seed: seed);

      for (int x = 0; x < width; x++) {
        for (int y = 0; y < height; y++) {
          for (int z = 0; z < height; z++) {
            double dx = x * frequency, dy = y * frequency, dz = z * frequency;

            map[x][y][z] = noise.singleCubic3(seed, dx, dy, dz);
          }
        }
      }

      return map;

    case NoiseType.CubicFractal:
      final noise = new CubicNoise(
          cellularReturnType: cellularReturnType,
          fractalType: fractalType,
          frequency: frequency,
          gain: gain,
          interp: interp,
          lacunarity: lacunarity,
          octaves: octaves,
          seed: seed);

      for (int x = 0; x < width; x++) {
        for (int y = 0; y < height; y++) {
          for (int z = 0; z < height; z++) {
            double dx = x * frequency, dy = y * frequency, dz = z * frequency;

            switch (fractalType) {
              case FractalType.FBM:
                map[x][y][z] = noise.singleCubicFractalFBM3(dx, dy, dz);
                break;
              case FractalType.Billow:
                map[x][y][z] = noise.singleCubicFractalBillow3(dx, dy, dz);
                break;
              case FractalType.RigidMulti:
                map[x][y][z] = noise.singleCubicFractalRigidMulti3(dx, dy, dz);
                break;
            }
          }
        }
      }

      return map;

    case NoiseType.Perlin:
      final noise = new PerlinNoise(
          cellularReturnType: cellularReturnType,
          fractalType: fractalType,
          frequency: frequency,
          gain: gain,
          interp: interp,
          lacunarity: lacunarity,
          octaves: octaves,
          seed: seed);

      for (int x = 0; x < width; x++) {
        for (int y = 0; y < height; y++) {
          for (int z = 0; z < height; z++) {
            double dx = x * frequency, dy = y * frequency, dz = z * frequency;

            map[x][y][z] = noise.singlePerlin3(seed, dx, dy, dz);
          }
        }
      }

      return map;

    case NoiseType.PerlinFractal:
      final noise = new PerlinNoise(
          cellularReturnType: cellularReturnType,
          fractalType: fractalType,
          frequency: frequency,
          gain: gain,
          interp: interp,
          lacunarity: lacunarity,
          octaves: octaves,
          seed: seed);

      for (int x = 0; x < width; x++) {
        for (int y = 0; y < height; y++) {
          for (int z = 0; z < height; z++) {
            double dx = x * frequency, dy = y * frequency, dz = z * frequency;

            switch (fractalType) {
              case FractalType.FBM:
                map[x][y][z] = noise.singlePerlinFractalFBM3(dx, dy, dz);
                break;
              case FractalType.Billow:
                map[x][y][z] = noise.singlePerlinFractalBillow3(dx, dy, dz);
                break;
              case FractalType.RigidMulti:
                map[x][y][z] = noise.singlePerlinFractalRigidMulti3(dx, dy, dz);
                break;
            }
          }
        }
      }

      return map;

    case NoiseType.Simplex:
      final noise = new SimplexNoise(
          cellularReturnType: cellularReturnType,
          fractalType: fractalType,
          frequency: frequency,
          gain: gain,
          interp: interp,
          lacunarity: lacunarity,
          octaves: octaves,
          seed: seed);

      for (int x = 0; x < width; x++) {
        for (int y = 0; y < height; y++) {
          for (int z = 0; z < height; z++) {
            double dx = x * frequency, dy = y * frequency, dz = z * frequency;

            map[x][y][z] = noise.singleSimplex3(seed, dx, dy, dz);
          }
        }
      }

      return map;

    case NoiseType.SimplexFractal:
      final noise = new SimplexNoise(
          cellularReturnType: cellularReturnType,
          fractalType: fractalType,
          frequency: frequency,
          gain: gain,
          interp: interp,
          lacunarity: lacunarity,
          octaves: octaves,
          seed: seed);

      for (int x = 0; x < width; x++) {
        for (int y = 0; y < height; y++) {
          for (int z = 0; z < height; z++) {
            double dx = x * frequency, dy = y * frequency, dz = z * frequency;

            switch (fractalType) {
              case FractalType.FBM:
                map[x][y][z] = noise.singleSimplexFractalFBM3(dx, dy, dz);
                break;
              case FractalType.Billow:
                map[x][y][z] = noise.singleSimplexFractalBillow3(dx, dy, dz);
                break;
              case FractalType.RigidMulti:
                map[x][y][z] =
                    noise.singleSimplexFractalRigidMulti3(dx, dy, dz);
                break;
            }
          }
        }
      }

      return map;

    case NoiseType.Value:
      final noise = new ValueNoise(
          cellularReturnType: cellularReturnType,
          fractalType: fractalType,
          frequency: frequency,
          gain: gain,
          interp: interp,
          lacunarity: lacunarity,
          octaves: octaves,
          seed: seed);

      for (int x = 0; x < width; x++) {
        for (int y = 0; y < height; y++) {
          for (int z = 0; z < height; z++) {
            double dx = x * frequency, dy = y * frequency, dz = z * frequency;

            map[x][y][z] = noise.singleValue3(seed, dx, dy, dz);
          }
        }
      }

      return map;

    case NoiseType.ValueFractal:
      final noise = new ValueNoise(
          cellularReturnType: cellularReturnType,
          fractalType: fractalType,
          frequency: frequency,
          gain: gain,
          interp: interp,
          lacunarity: lacunarity,
          octaves: octaves,
          seed: seed);

      for (int x = 0; x < width; x++) {
        for (int y = 0; y < height; y++) {
          for (int z = 0; z < height; z++) {
            double dx = x * frequency, dy = y * frequency, dz = z * frequency;

            switch (fractalType) {
              case FractalType.FBM:
                map[x][y][z] = noise.singleValueFractalFBM3(dx, dy, dz);
                break;
              case FractalType.Billow:
                map[x][y][z] = noise.singleValueFractalBillow3(dx, dy, dz);
                break;
              case FractalType.RigidMulti:
                map[x][y][z] = noise.singleValueFractalRigidMulti3(dx, dy, dz);
                break;
            }
          }
        }
      }

      return map;

    case NoiseType.WhiteNoise:
      final noise = new WhiteNoise(seed: seed);

      for (int x = 0; x < width; x++) {
        for (int y = 0; y < height; y++) {
          for (int z = 0; z < height; z++) {
            double dx = x * frequency, dy = y * frequency, dz = z * frequency;

            map[x][y][z] = noise.getWhiteNoise3(dx, dy, dz);
          }
        }
      }

      return map;
  }

  return map;
}
