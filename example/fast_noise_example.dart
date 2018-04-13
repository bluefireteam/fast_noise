import 'package:fast_noise/fast_noise.dart';

main() {
  var watch = new Stopwatch()..start();
  var w = 128, h = 128;
  var heightMap = getNoise2(w, h, noiseType: NoiseType.WhiteNoise);

  watch.stop();

  print('noise: ${watch.elapsedMilliseconds}ms');
  print(heightMap);
}
