abstract class Noise2 {
  double getNoise2(double x, double y);
}

abstract class Noise3 {
  double getNoise3(double x, double y, double z);
}

abstract class Noise2And3 implements Noise2, Noise3 {}

abstract class Noise4 {
  double getNoise4(double x, double y, double z, double w);
}

abstract class Noise2Int {
  double getNoiseInt2(int x, int y);
}

abstract class Noise3Int {
  double getNoiseInt3(int x, int y, int z);
}

abstract class Noise4Int {
  double getNoiseInt4(int x, int y, int z, int w);
}
