import 'package:benchmark_harness/benchmark_harness.dart';

import 'package:fast_noise/fast_noise.dart';

class SimplexFractalBenchmark extends BenchmarkBase {
  const SimplexFractalBenchmark() : super('SimplexFractal');

  static void main() {
    SimplexFractalBenchmark().report();
  }

  @override
  void run() {
    noise2(128, 128, noiseType: NoiseType.SimplexFractal);
  }

  @override
  void setup() {}

  @override
  void teardown() {}
}

void main() {
  SimplexFractalBenchmark.main();
}
