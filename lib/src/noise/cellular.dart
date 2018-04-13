import 'dart:math' as math;

import 'package:fast_noise/src/float.dart';
import 'package:fast_noise/src/math.dart';

import 'package:fast_noise/src/noise/enums.dart';

class CellularNoise {
  static const double gradientPerturbAmp = 1.0 / 0.45;

  final int seed, octaves;
  final double frequency, lacunarity, gain;
  final Interp interp;
  final FractalType fractalType;
  final CellularDistanceFunction cellularDistanceFunction;
  final CellularReturnType cellularReturnType;
  final double fractalBounding;

  CellularNoise(
      {this.seed: 1337,
      this.frequency: .01,
      this.interp: Interp.Quintic,
      this.octaves: 3,
      this.lacunarity: 2.0,
      this.gain: .5,
      this.fractalType: FractalType.FBM,
      this.cellularDistanceFunction: CellularDistanceFunction.Euclidean,
      this.cellularReturnType: CellularReturnType.CellValue})
      : this.fractalBounding = calculateFractalBounding(gain, octaves);

  double getCellular3(double x, double y, double z) {
    x *= frequency;
    y *= frequency;
    z *= frequency;

    switch (cellularReturnType) {
      case CellularReturnType.CellValue:
      case CellularReturnType.Distance:
        return singleCellular3(x, y, z);
      default:
        return singleCellular2Edge3(x, y, z);
    }
  }

  double singleCellular3(double x, double y, double z) {
    int xr = fastRound(x), yr = fastRound(y), zr = fastRound(z);

    double distance = 999999.0;
    int xc = 0, yc = 0, zc = 0;

    switch (cellularDistanceFunction) {
      case CellularDistanceFunction.Euclidean:
        for (int xi = xr - 1; xi <= xr + 1; xi++) {
          for (int yi = yr - 1; yi <= yr + 1; yi++) {
            for (int zi = zr - 1; zi <= zr + 1; zi++) {
              Float3 vec = CELL_3D[hash3D(seed, xi, yi, zi) & 255];

              double vecX = xi - x + vec.x,
                  vecY = yi - y + vec.y,
                  vecZ = zi - z + vec.z,
                  newDistance = vecX * vecX + vecY * vecY + vecZ * vecZ;

              if (newDistance < distance) {
                distance = newDistance;
                xc = xi;
                yc = yi;
                zc = zi;
              }
            }
          }
        }
        break;
      case CellularDistanceFunction.Manhattan:
        for (int xi = xr - 1; xi <= xr + 1; xi++) {
          for (int yi = yr - 1; yi <= yr + 1; yi++) {
            for (int zi = zr - 1; zi <= zr + 1; zi++) {
              Float3 vec = CELL_3D[hash3D(seed, xi, yi, zi) & 255];

              double vecX = xi - x + vec.x,
                  vecY = yi - y + vec.y,
                  vecZ = zi - z + vec.z,
                  newDistance = vecX.abs() + vecY.abs() + vecZ.abs();

              if (newDistance < distance) {
                distance = newDistance;
                xc = xi;
                yc = yi;
                zc = zi;
              }
            }
          }
        }
        break;
      case CellularDistanceFunction.Natural:
        for (int xi = xr - 1; xi <= xr + 1; xi++) {
          for (int yi = yr - 1; yi <= yr + 1; yi++) {
            for (int zi = zr - 1; zi <= zr + 1; zi++) {
              Float3 vec = CELL_3D[hash3D(seed, xi, yi, zi) & 255];

              double vecX = xi - x + vec.x,
                  vecY = yi - y + vec.y,
                  vecZ = zi - z + vec.z,
                  newDistance = (vecX.abs() + vecY.abs() + vecZ.abs()) +
                      (vecX * vecX + vecY * vecY + vecZ * vecZ);

              if (newDistance < distance) {
                distance = newDistance;
                xc = xi;
                yc = yi;
                zc = zi;
              }
            }
          }
        }
        break;
    }

    switch (cellularReturnType) {
      case CellularReturnType.CellValue:
        return valCoord3D(0, xc, yc, zc);

      case CellularReturnType.Distance:
        return distance - 1.0;
      default:
        return .0;
    }
  }

  double singleCellular2Edge3(double x, double y, double z) {
    int xr = fastRound(x);
    int yr = fastRound(y);
    int zr = fastRound(z);

    double distance = 999999.0;
    double distance2 = 999999.0;

    switch (cellularDistanceFunction) {
      case CellularDistanceFunction.Euclidean:
        for (int xi = xr - 1; xi <= xr + 1; xi++) {
          for (int yi = yr - 1; yi <= yr + 1; yi++) {
            for (int zi = zr - 1; zi <= zr + 1; zi++) {
              Float3 vec = CELL_3D[hash3D(seed, xi, yi, zi) & 255];

              double vecX = xi - x + vec.x,
                  vecY = yi - y + vec.y,
                  vecZ = zi - z + vec.z,
                  newDistance = vecX * vecX + vecY * vecY + vecZ * vecZ;

              distance2 = math.max(math.min(distance2, newDistance), distance);
              distance = math.min(distance, newDistance);
            }
          }
        }
        break;
      case CellularDistanceFunction.Manhattan:
        for (int xi = xr - 1; xi <= xr + 1; xi++) {
          for (int yi = yr - 1; yi <= yr + 1; yi++) {
            for (int zi = zr - 1; zi <= zr + 1; zi++) {
              Float3 vec = CELL_3D[hash3D(seed, xi, yi, zi) & 255];

              double vecX = xi - x + vec.x,
                  vecY = yi - y + vec.y,
                  vecZ = zi - z + vec.z,
                  newDistance = vecX.abs() + vecY.abs() + vecZ.abs();

              distance2 = math.max(math.min(distance2, newDistance), distance);
              distance = math.min(distance, newDistance);
            }
          }
        }
        break;
      case CellularDistanceFunction.Natural:
        for (int xi = xr - 1; xi <= xr + 1; xi++) {
          for (int yi = yr - 1; yi <= yr + 1; yi++) {
            for (int zi = zr - 1; zi <= zr + 1; zi++) {
              Float3 vec = CELL_3D[hash3D(seed, xi, yi, zi) & 255];

              double vecX = xi - x + vec.x,
                  vecY = yi - y + vec.y,
                  vecZ = zi - z + vec.z,
                  newDistance = (vecX.abs() + vecY.abs() + vecZ.abs()) +
                      (vecX * vecX + vecY * vecY + vecZ * vecZ);

              distance2 = math.max(math.min(distance2, newDistance), distance);
              distance = math.min(distance, newDistance);
            }
          }
        }
        break;
      default:
        break;
    }

    switch (cellularReturnType) {
      case CellularReturnType.Distance2:
        return distance2 - 1.0;
      case CellularReturnType.Distance2Add:
        return distance2 + distance - 1.0;
      case CellularReturnType.Distance2Sub:
        return distance2 - distance - 1.0;
      case CellularReturnType.Distance2Mul:
        return distance2 * distance - 1.0;
      case CellularReturnType.Distance2Div:
        return distance / distance2 - 1.0;
      default:
        return .0;
    }
  }

  double getCellular2(double x, double y) {
    x *= frequency;
    y *= frequency;

    switch (cellularReturnType) {
      case CellularReturnType.CellValue:
      case CellularReturnType.Distance:
        return singleCellular2(x, y);
      default:
        return singleCellular2Edge2(x, y);
    }
  }

  double singleCellular2(double x, double y) {
    int xr = fastRound(x), yr = fastRound(y);

    double distance = 999999.0;
    int xc = 0, yc = 0;

    switch (cellularDistanceFunction) {
      case CellularDistanceFunction.Euclidean:
        for (int xi = xr - 1; xi <= xr + 1; xi++) {
          for (int yi = yr - 1; yi <= yr + 1; yi++) {
            Float2 vec = CELL_2D[hash2D(seed, xi, yi) & 255];

            double vecX = xi - x + vec.x,
                vecY = yi - y + vec.y,
                newDistance = vecX * vecX + vecY * vecY;

            if (newDistance < distance) {
              distance = newDistance;
              xc = xi;
              yc = yi;
            }
          }
        }
        break;
      case CellularDistanceFunction.Manhattan:
        for (int xi = xr - 1; xi <= xr + 1; xi++) {
          for (int yi = yr - 1; yi <= yr + 1; yi++) {
            Float2 vec = CELL_2D[hash2D(seed, xi, yi) & 255];

            double vecX = xi - x + vec.x,
                vecY = yi - y + vec.y,
                newDistance = (vecX.abs() + vecY.abs());

            if (newDistance < distance) {
              distance = newDistance;
              xc = xi;
              yc = yi;
            }
          }
        }
        break;
      case CellularDistanceFunction.Natural:
        for (int xi = xr - 1; xi <= xr + 1; xi++) {
          for (int yi = yr - 1; yi <= yr + 1; yi++) {
            Float2 vec = CELL_2D[hash2D(seed, xi, yi) & 255];

            double vecX = xi - x + vec.x,
                vecY = yi - y + vec.y,
                newDistance =
                    (vecX.abs() + vecY.abs()) + (vecX * vecX + vecY * vecY);

            if (newDistance < distance) {
              distance = newDistance;
              xc = xi;
              yc = yi;
            }
          }
        }
        break;
    }

    switch (cellularReturnType) {
      case CellularReturnType.CellValue:
        return valCoord2D(0, xc, yc);

      case CellularReturnType.Distance:
        return distance - 1.0;
      default:
        return .0;
    }
  }

  double singleCellular2Edge2(double x, double y) {
    int xr = fastRound(x), yr = fastRound(y);

    double distance = 999999.0, distance2 = 999999.0;

    switch (cellularDistanceFunction) {
      case CellularDistanceFunction.Euclidean:
        for (int xi = xr - 1; xi <= xr + 1; xi++) {
          for (int yi = yr - 1; yi <= yr + 1; yi++) {
            Float2 vec = CELL_2D[hash2D(seed, xi, yi) & 255];

            double vecX = xi - x + vec.x,
                vecY = yi - y + vec.y,
                newDistance = vecX * vecX + vecY * vecY;

            distance2 = math.max(math.min(distance2, newDistance), distance);
            distance = math.min(distance, newDistance);
          }
        }
        break;
      case CellularDistanceFunction.Manhattan:
        for (int xi = xr - 1; xi <= xr + 1; xi++) {
          for (int yi = yr - 1; yi <= yr + 1; yi++) {
            Float2 vec = CELL_2D[hash2D(seed, xi, yi) & 255];

            double vecX = xi - x + vec.x,
                vecY = yi - y + vec.y,
                newDistance = vecX.abs() + vecY.abs();

            distance2 = math.max(math.min(distance2, newDistance), distance);
            distance = math.min(distance, newDistance);
          }
        }
        break;
      case CellularDistanceFunction.Natural:
        for (int xi = xr - 1; xi <= xr + 1; xi++) {
          for (int yi = yr - 1; yi <= yr + 1; yi++) {
            Float2 vec = CELL_2D[hash2D(seed, xi, yi) & 255];

            double vecX = xi - x + vec.x,
                vecY = yi - y + vec.y,
                newDistance =
                    (vecX.abs() + vecY.abs()) + (vecX * vecX + vecY * vecY);

            distance2 = math.max(math.min(distance2, newDistance), distance);
            distance = math.min(distance, newDistance);
          }
        }
        break;
    }

    switch (cellularReturnType) {
      case CellularReturnType.Distance2:
        return distance2 - 1.0;
      case CellularReturnType.Distance2Add:
        return distance2 + distance - 1.0;
      case CellularReturnType.Distance2Sub:
        return distance2 - distance - 1.0;
      case CellularReturnType.Distance2Mul:
        return distance2 * distance - 1.0;
      case CellularReturnType.Distance2Div:
        return distance / distance2 - 1.0;
      default:
        return .0;
    }
  }

  void gradientPerturb3(Vector3f v3) =>
      singleGradientPerturb3(seed, gradientPerturbAmp, frequency, v3);

  void gradientPerturbFractal3(Vector3f v3) {
    int seed = this.seed;
    double amp = gradientPerturbAmp * fractalBounding, freq = frequency;

    singleGradientPerturb3(seed, amp, frequency, v3);

    for (int i = 1; i < octaves; i++) {
      freq *= lacunarity;
      amp *= gain;
      singleGradientPerturb3(++seed, amp, freq, v3);
    }
  }

  void singleGradientPerturb3(
      int seed, double perturbAmp, double frequency, Vector3f v3) {
    double xf = v3.x * frequency, yf = v3.y * frequency, zf = v3.z * frequency;

    int x0 = fastFloor(xf),
        y0 = fastFloor(yf),
        z0 = fastFloor(zf),
        x1 = x0 + 1,
        y1 = y0 + 1,
        z1 = z0 + 1;

    double xs, ys, zs;
    switch (interp) {
      case Interp.Linear:
        xs = xf - x0;
        ys = yf - y0;
        zs = zf - z0;
        break;
      case Interp.Hermite:
        xs = interpHermiteFunc(xf - x0);
        ys = interpHermiteFunc(yf - y0);
        zs = interpHermiteFunc(zf - z0);
        break;
      case Interp.Quintic:
        xs = interpQuinticFunc(xf - x0);
        ys = interpQuinticFunc(yf - y0);
        zs = interpQuinticFunc(zf - z0);
        break;
    }

    Float3 vec0 = CELL_3D[hash3D(seed, x0, y0, z0) & 255],
        vec1 = CELL_3D[hash3D(seed, x1, y0, z0) & 255];

    double lx0x = lerp(vec0.x, vec1.x, xs),
        ly0x = lerp(vec0.y, vec1.y, xs),
        lz0x = lerp(vec0.z, vec1.z, xs);

    vec0 = CELL_3D[hash3D(seed, x0, y1, z0) & 255];
    vec1 = CELL_3D[hash3D(seed, x1, y1, z0) & 255];

    double lx1x = lerp(vec0.x, vec1.x, xs),
        ly1x = lerp(vec0.y, vec1.y, xs),
        lz1x = lerp(vec0.z, vec1.z, xs),
        lx0y = lerp(lx0x, lx1x, ys),
        ly0y = lerp(ly0x, ly1x, ys),
        lz0y = lerp(lz0x, lz1x, ys);

    vec0 = CELL_3D[hash3D(seed, x0, y0, z1) & 255];
    vec1 = CELL_3D[hash3D(seed, x1, y0, z1) & 255];

    lx0x = lerp(vec0.x, vec1.x, xs);
    ly0x = lerp(vec0.y, vec1.y, xs);
    lz0x = lerp(vec0.z, vec1.z, xs);

    vec0 = CELL_3D[hash3D(seed, x0, y1, z1) & 255];
    vec1 = CELL_3D[hash3D(seed, x1, y1, z1) & 255];

    lx1x = lerp(vec0.x, vec1.x, xs);
    ly1x = lerp(vec0.y, vec1.y, xs);
    lz1x = lerp(vec0.z, vec1.z, xs);

    v3.x += lerp(lx0y, lerp(lx0x, lx1x, ys), zs) * perturbAmp;
    v3.y += lerp(ly0y, lerp(ly0x, ly1x, ys), zs) * perturbAmp;
    v3.z += lerp(lz0y, lerp(lz0x, lz1x, ys), zs) * perturbAmp;
  }

  void gradientPerturb2(Vector2f v2) =>
      singleGradientPerturb2(seed, gradientPerturbAmp, frequency, v2);

  void gradientPerturbFractal2(Vector2f v2) {
    int seed = this.seed;
    double amp = gradientPerturbAmp * fractalBounding, freq = frequency;

    singleGradientPerturb2(seed, amp, frequency, v2);

    for (int i = 1; i < octaves; i++) {
      freq *= lacunarity;
      amp *= gain;
      singleGradientPerturb2(++seed, amp, freq, v2);
    }
  }

  void singleGradientPerturb2(
      int seed, double perturbAmp, double frequency, Vector2f v2) {
    double xf = v2.x * frequency, yf = v2.y * frequency;

    int x0 = fastFloor(xf), y0 = fastFloor(yf), x1 = x0 + 1, y1 = y0 + 1;

    double xs, ys;
    switch (interp) {
      case Interp.Linear:
        xs = xf - x0;
        ys = yf - y0;
        break;
      case Interp.Hermite:
        xs = interpHermiteFunc(xf - x0);
        ys = interpHermiteFunc(yf - y0);
        break;
      case Interp.Quintic:
        xs = interpQuinticFunc(xf - x0);
        ys = interpQuinticFunc(yf - y0);
        break;
    }

    Float2 vec0 = CELL_2D[hash2D(seed, x0, y0) & 255],
        vec1 = CELL_2D[hash2D(seed, x1, y0) & 255];

    double lx0x = lerp(vec0.x, vec1.x, xs), ly0x = lerp(vec0.y, vec1.y, xs);

    vec0 = CELL_2D[hash2D(seed, x0, y1) & 255];
    vec1 = CELL_2D[hash2D(seed, x1, y1) & 255];

    double lx1x = lerp(vec0.x, vec1.x, xs), ly1x = lerp(vec0.y, vec1.y, xs);

    v2.x += lerp(lx0x, lx1x, ys) * perturbAmp;
    v2.y += lerp(ly0x, ly1x, ys) * perturbAmp;
  }
}
