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

Future<ui.Image> convertImageToFlutterUi(img.Image image) async {
  if (image.format != img.Format.uint8 || image.numChannels != 4) {
    final cmd = img.Command()
      ..image(image)
      ..convert(format: img.Format.uint8, numChannels: 4);
    final rgba8 = await cmd.getImageThread();
    if (rgba8 != null) {
      image = rgba8;
    }
  }

  ui.ImmutableBuffer buffer = await ui.ImmutableBuffer.fromUint8List(
    image.toUint8List(),
  );

  ui.ImageDescriptor id = ui.ImageDescriptor.raw(
    buffer,
    height: image.height,
    width: image.width,
    pixelFormat: ui.PixelFormat.rgba8888,
  );

  ui.Codec codec = await id.instantiateCodec(
    targetHeight: image.height,
    targetWidth: image.width,
  );

  ui.FrameInfo fi = await codec.getNextFrame();
  ui.Image uiImage = fi.image;

  return uiImage;
}
