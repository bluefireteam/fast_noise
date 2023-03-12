import 'dart:async';
import 'dart:ui' as ui;

import 'package:fast_noise/fast_noise.dart';
import 'package:image/image.dart' as img;

Future<ui.Image> generate({
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
  const scaleFactor = 2;
  final image = img.Image(
    width: width * scaleFactor,
    height: height * scaleFactor,
  );

  for (var x = 0; x < width; x++) {
    for (var y = 0; y < height; y++) {
      final value = (0x80 + 0x80 * map[x][y]).floor(); // gray-scale

      for (var i = 0; i < scaleFactor; i++) {
        for (var j = 0; j < scaleFactor; j++) {
          image.setPixelRgba(
            x * scaleFactor + i,
            y * scaleFactor + j,
            value,
            value,
            value,
            0xff,
          );
        }
      }
    }
  }

  return convertImageToFlutterUi(image);
}

Future<img.Image> _convertToRgba8(img.Image genericImage) async {
  if (genericImage.format != img.Format.uint8 ||
      genericImage.numChannels != 4) {
    final cmd = img.Command()
      ..image(genericImage)
      ..convert(format: img.Format.uint8, numChannels: 4);
    final rgba8 = await cmd.getImageThread();
    if (rgba8 != null) {
      return rgba8;
    }
  }
  return genericImage;
}

Future<ui.Image> convertImageToFlutterUi(img.Image genericImage) async {
  final image = await _convertToRgba8(genericImage);

  final buffer = await ui.ImmutableBuffer.fromUint8List(
    image.toUint8List(),
  );

  final id = ui.ImageDescriptor.raw(
    buffer,
    height: image.height,
    width: image.width,
    pixelFormat: ui.PixelFormat.rgba8888,
  );

  final codec = await id.instantiateCodec(
    targetHeight: image.height,
    targetWidth: image.width,
  );

  final fi = await codec.getNextFrame();
  final uiImage = fi.image;

  return uiImage;
}
