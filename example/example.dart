import 'dart:html';

import 'package:fast_noise/fast_noise.dart';

void main() {
  const w = 512, h = 512;
  final canvas = new CanvasElement(width: w, height: h);
  final map = _getCellular(w, h);
  final context = canvas.getContext('2d') as CanvasRenderingContext2D;

  context.imageSmoothingEnabled = false;

  for (int x = 0; x < w; x++) {
    for (int y = 0; y < h; y++) {
      var imageData = context.createImageData(1, 1);
      var value = map[x][y].abs();

      imageData.data[0] = (255 * value).floor();
      imageData.data[1] = (255 * value).floor();
      imageData.data[2] = (255 * value).floor();
      imageData.data[3] = 255;

      context.putImageData(imageData, x, y, 0, 0, w, h);
    }
  }

  document.body.append(canvas);
}

List<List<double>> _getCellular(int w, int h) => noise2(w, h,
    noiseType: NoiseType.Cellular,
    octaves: 5,
    frequency: 0.015,
    cellularDistanceFunction: CellularDistanceFunction.Euclidean,
    cellularReturnType: CellularReturnType.Distance2Add);