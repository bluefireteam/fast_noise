import 'dart:html';

import 'package:fast_noise/fast_noise.dart';

void main() {
  const w = 512, h = 512;
  final canvas = new CanvasElement(width: w, height: h);
  final map = _getCellular(w, h);
  final context = canvas.getContext('2d') as CanvasRenderingContext2D;
  final imageData = context.createImageData(w, h);

  context.imageSmoothingEnabled = false;

  for (int x = 0; x < w; x++) {
    for (int y = 0; y < h; y++) {
      var s = 4 * (y * h + x);
      var value = (128 + 128 * map[x][y]).floor();

      imageData.data[s] = imageData.data[s + 1] = imageData.data[s + 2] = value;
      imageData.data[s + 3] = 255;
    }
  }

  context.putImageData(imageData, 0, 0, 0, 0, w, h);

  document.body.append(canvas);
}

List<List<double>> _getCellular(int w, int h) => noise2(w, h,
    noiseType: NoiseType.Cellular,
    octaves: 5,
    frequency: 0.015,
    cellularDistanceFunction: CellularDistanceFunction.Euclidean,
    cellularReturnType: CellularReturnType.Distance2Add);
