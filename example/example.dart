import 'dart:io';

import 'package:image/image.dart' as img;
import 'package:fast_noise/fast_noise.dart';

void main() {
  const w = 512, h = 512;
  final map = _getCellular(w, h);
  final image = img.Image.rgb(w, h);

  for (var x = 0; x < w; x++) {
    for (var y = 0; y < h; y++) {
      var value = (0x80 + 0x80 * map[x][y]).floor(); // grayscale

      image.setPixelRgba(x, y, value, value, value, 0xff);
    }
  }

  File('./example/noise.png').writeAsBytesSync(img.encodePng(image));
}

List<List<double>> _getCellular(int w, int h) => noise2(w, h,
    noiseType: NoiseType.Cellular,
    octaves: 5,
    frequency: 0.015,
    cellularDistanceFunction: CellularDistanceFunction.Euclidean,
    cellularReturnType: CellularReturnType.Distance2Add);
