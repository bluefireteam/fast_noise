import 'package:fast_noise/src/utils.dart';

class WhiteNoise {
  final int seed;

  WhiteNoise({this.seed: 1337});

  double getWhiteNoise2(double x, double y) =>
      valCoord2D(seed, x.toInt(), y.toInt());

  double getWhiteNoise3(double x, double y, double z) =>
      valCoord3D(seed, x.toInt(), y.toInt(), z.toInt());

  double getWhiteNoise4(double x, double y, double z, double w) =>
      valCoord4D(seed, x.toInt(), y.toInt(), z.toInt(), w.toInt());

  double getWhiteNoiseInt2(int x, int y) {
    return valCoord2D(seed, x, y);
  }

  double getWhiteNoiseInt3(int x, int y, int z) {
    return valCoord3D(seed, x, y, z);
  }

  double getWhiteNoiseInt4(int x, int y, int z, int w) {
    return valCoord4D(seed, x, y, z, w);
  }
}
