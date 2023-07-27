import 'package:fast_noise/fast_noise.dart';

class WhiteNoise
    implements Noise2And3, Noise4, Noise2Int, Noise3Int, Noise4Int {
  final int seed;
  final double frequency;

  WhiteNoise({this.seed = 1337, this.frequency = 1.0});

  @override
  double getNoise2(double x, double y) {
    final dx = x * frequency;
    final dy = y * frequency;
    return getNoiseInt2(dx.toInt(), dy.toInt());
  }

  @override
  double getNoise3(double x, double y, double z) {
    final dx = x * frequency;
    final dy = y * frequency;
    final dz = z * frequency;
    return getNoiseInt3(dx.toInt(), dy.toInt(), dz.toInt());
  }

  @override
  double getNoise4(double x, double y, double z, double w) {
    final dx = x * frequency;
    final dy = y * frequency;
    final dz = z * frequency;
    final dw = w * frequency;
    return getNoiseInt4(dx.toInt(), dy.toInt(), dz.toInt(), dw.toInt());
  }

  @override
  double getNoiseInt2(int x, int y) => valCoord2D(seed, x, y);

  @override
  double getNoiseInt3(int x, int y, int z) => valCoord3D(seed, x, y, z);

  @override
  double getNoiseInt4(int x, int y, int z, int w) =>
      valCoord4D(seed, x, y, z, w);
}
