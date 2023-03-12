import 'dart:typed_data';

import 'package:fast_noise/fast_noise.dart';
import 'package:image/image.dart' as img;

Uint8List generate({
  required int width,
  required int height,
  required int seed,
  required NoiseType noiseType,
  required double frequency,
  required Interp interp,
  required int octaves,
  required double lacunarity,
  required double gain,
  required FractalType fractalType,
  required CellularDistanceFunction cellularDistanceFunction,
  required CellularReturnType cellularReturnType,
}) {
  final map = noise2(
    width,
    height,
    seed: seed,
    noiseType: noiseType,
    frequency: frequency,
    interp: interp,
    octaves: octaves,
    lacunarity: lacunarity,
    gain: gain,
    fractalType: fractalType,
    cellularDistanceFunction: cellularDistanceFunction,
    cellularReturnType: cellularReturnType,
  );
  final image = img.Image(width: width, height: height);

  for (var x = 0; x < width; x++) {
    for (var y = 0; y < height; y++) {
      var value = (0x80 + 0x80 * map[x][y]).floor(); // gray-scale

      image.setPixelRgba(x, y, value, value, value, 0xff);
    }
  }

  return img.encodeBmp(image);
}
