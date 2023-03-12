import 'dart:math' as math;

import 'package:fast_noise/fast_noise.dart';

class CellularNoise implements Noise2And3 {
  final int seed;
  final double frequency;
  final CellularDistanceFunction cellularDistanceFunction;
  final CellularReturnType cellularReturnType;

  CellularNoise({
    this.seed = 1337,
    this.frequency = .01,
    this.cellularDistanceFunction = CellularDistanceFunction.Euclidean,
    this.cellularReturnType = CellularReturnType.CellValue,
  });

  @override
  double getNoise3(double x, double y, double z) {
    final dx = x * frequency;
    final dy = y * frequency;
    final dz = z * frequency;

    switch (cellularReturnType) {
      case CellularReturnType.CellValue:
      case CellularReturnType.Distance:
        return singleCellular3(dx, dy, dz);
      default:
        return singleCellular2Edge3(dx, dy, dz);
    }
  }

  double singleCellular3(double x, double y, double z) {
    final xr = x.round(), yr = y.round(), zr = z.round();

    var distance = 999999.0;
    var xc = 0, yc = 0, zc = 0;

    switch (cellularDistanceFunction) {
      case CellularDistanceFunction.Euclidean:
        for (var xi = xr - 1; xi <= xr + 1; xi++) {
          for (var yi = yr - 1; yi <= yr + 1; yi++) {
            for (var zi = zr - 1; zi <= zr + 1; zi++) {
              final vec = CELL_3D[hash3D(seed, xi, yi, zi) & 255];

              final vecX = xi - x + vec.x,
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
        for (var xi = xr - 1; xi <= xr + 1; xi++) {
          for (var yi = yr - 1; yi <= yr + 1; yi++) {
            for (var zi = zr - 1; zi <= zr + 1; zi++) {
              final vec = CELL_3D[hash3D(seed, xi, yi, zi) & 255];

              final vecX = xi - x + vec.x,
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
        for (var xi = xr - 1; xi <= xr + 1; xi++) {
          for (var yi = yr - 1; yi <= yr + 1; yi++) {
            for (var zi = zr - 1; zi <= zr + 1; zi++) {
              final vec = CELL_3D[hash3D(seed, xi, yi, zi) & 255];

              final vecX = xi - x + vec.x,
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
    final xr = x.round(), yr = y.round(), zr = z.round();
    var distance = 999999.0, distance2 = 999999.0;

    switch (cellularDistanceFunction) {
      case CellularDistanceFunction.Euclidean:
        for (var xi = xr - 1; xi <= xr + 1; xi++) {
          for (var yi = yr - 1; yi <= yr + 1; yi++) {
            for (var zi = zr - 1; zi <= zr + 1; zi++) {
              final vec = CELL_3D[hash3D(seed, xi, yi, zi) & 255];

              final vecX = xi - x + vec.x,
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
        for (var xi = xr - 1; xi <= xr + 1; xi++) {
          for (var yi = yr - 1; yi <= yr + 1; yi++) {
            for (var zi = zr - 1; zi <= zr + 1; zi++) {
              final vec = CELL_3D[hash3D(seed, xi, yi, zi) & 255];

              final vecX = xi - x + vec.x,
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
        for (var xi = xr - 1; xi <= xr + 1; xi++) {
          for (var yi = yr - 1; yi <= yr + 1; yi++) {
            for (var zi = zr - 1; zi <= zr + 1; zi++) {
              final vec = CELL_3D[hash3D(seed, xi, yi, zi) & 255];

              final vecX = xi - x + vec.x,
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

  @override
  double getNoise2(double x, double y) {
    final dx = x * frequency;
    final dy = y * frequency;

    switch (cellularReturnType) {
      case CellularReturnType.CellValue:
      case CellularReturnType.Distance:
        return singleCellular2(dx, dy);
      default:
        return singleCellular2Edge2(dx, dy);
    }
  }

  double singleCellular2(double x, double y) {
    final xr = x.round(), yr = y.round();
    var distance = 999999.0;
    var xc = 0, yc = 0;

    switch (cellularDistanceFunction) {
      case CellularDistanceFunction.Euclidean:
        for (var xi = xr - 1; xi <= xr + 1; xi++) {
          for (var yi = yr - 1; yi <= yr + 1; yi++) {
            final vec = CELL_2D[hash2D(seed, xi, yi) & 255];

            final vecX = xi - x + vec.x,
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
        for (var xi = xr - 1; xi <= xr + 1; xi++) {
          for (var yi = yr - 1; yi <= yr + 1; yi++) {
            final vec = CELL_2D[hash2D(seed, xi, yi) & 255];

            final vecX = xi - x + vec.x,
                vecY = yi - y + vec.y,
                newDistance = vecX.abs() + vecY.abs();

            if (newDistance < distance) {
              distance = newDistance;
              xc = xi;
              yc = yi;
            }
          }
        }
        break;
      case CellularDistanceFunction.Natural:
        for (var xi = xr - 1; xi <= xr + 1; xi++) {
          for (var yi = yr - 1; yi <= yr + 1; yi++) {
            final vec = CELL_2D[hash2D(seed, xi, yi) & 255];

            final vecX = xi - x + vec.x,
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
    final xr = x.round(), yr = y.round();
    var distance = 999999.0, distance2 = 999999.0;

    switch (cellularDistanceFunction) {
      case CellularDistanceFunction.Euclidean:
        for (var xi = xr - 1; xi <= xr + 1; xi++) {
          for (var yi = yr - 1; yi <= yr + 1; yi++) {
            final vec = CELL_2D[hash2D(seed, xi, yi) & 255];

            final vecX = xi - x + vec.x,
                vecY = yi - y + vec.y,
                newDistance = vecX * vecX + vecY * vecY;

            distance2 = math.max(math.min(distance2, newDistance), distance);
            distance = math.min(distance, newDistance);
          }
        }
        break;
      case CellularDistanceFunction.Manhattan:
        for (var xi = xr - 1; xi <= xr + 1; xi++) {
          for (var yi = yr - 1; yi <= yr + 1; yi++) {
            final vec = CELL_2D[hash2D(seed, xi, yi) & 255];

            final vecX = xi - x + vec.x,
                vecY = yi - y + vec.y,
                newDistance = vecX.abs() + vecY.abs();

            distance2 = math.max(math.min(distance2, newDistance), distance);
            distance = math.min(distance, newDistance);
          }
        }
        break;
      case CellularDistanceFunction.Natural:
        for (var xi = xr - 1; xi <= xr + 1; xi++) {
          for (var yi = yr - 1; yi <= yr + 1; yi++) {
            final vec = CELL_2D[hash2D(seed, xi, yi) & 255];

            final vecX = xi - x + vec.x,
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
}
