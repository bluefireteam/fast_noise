import 'package:fast_noise/src/utils.dart';

class WhiteNoise {
  final int seed;

  WhiteNoise({this.seed = 1337});

  double getWhiteNoise2(int x, int y) => valCoord2D(seed, x, y);

  double getWhiteNoise3(int x, int y, int z) => valCoord3D(seed, x, y, z);

  double getWhiteNoise4(int x, int y, int z, int w) =>
      valCoord4D(seed, x, y, z, w);

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
