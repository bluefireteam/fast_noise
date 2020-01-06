import 'package:fast_noise/fast_noise.dart';

//todo: write tests
void main() {
  var watch = Stopwatch()..start();
  var w = 128, h = 128;
  var heightMap = noise2(w, h, noiseType: NoiseType.WhiteNoise);

  watch.stop();

  print('noise: ${watch.elapsedMilliseconds}ms');
  print(heightMap);
}
