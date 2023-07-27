import 'dart:html';

import 'package:fast_noise/fast_noise.dart';

void main() {
  final sizeInput = querySelector('#input-size') as InputElement?;
  final seedInput = querySelector('#input-seed') as InputElement?;
  final freqInput = querySelector('#input-freq') as InputElement?;
  final gainInput = querySelector('#input-gain') as InputElement?;
  final lacunarityInput = querySelector('#input-lacunarity') as InputElement?;
  final octavesInput = querySelector('#input-octaves') as InputElement?;

  final noiseTypeSelect = querySelector('#select-noise-type') as SelectElement?;
  final fractalTypeSelect =
      querySelector('#select-fractal-type') as SelectElement?;
  final interpTypeSelect = querySelector('#select-interp') as SelectElement?;
  final cellDistFnSelect =
      querySelector('#select-cellular-distance-fnc') as SelectElement?;
  final cellRetTypeSelect =
      querySelector('#select-cellular-return-type') as SelectElement?;
  final renderButton = querySelector('#render-now')!;

  renderButton.onClick.listen((_) {
    final size = int.parse(sizeInput!.value!);
    final seed = int.parse(seedInput!.value!);
    final freq = double.parse(freqInput!.value!).toInt();
    final gain = double.parse(gainInput!.value!).toInt();
    final lacunarity = double.parse(lacunarityInput!.value!).toInt();
    final octaves = int.parse(octavesInput!.value!);
    NoiseType? noiseType;
    FractalType? fractalType;
    Interp? interp;
    CellularReturnType? cellularReturnType;
    CellularDistanceFunction? cellularDistanceFunction;

    switch (noiseTypeSelect!.value) {
      case 'Cellular':
        noiseType = NoiseType.cellular;
        break;
      case 'Cubic':
        noiseType = NoiseType.cubic;
        break;
      case 'CubicFractal':
        noiseType = NoiseType.cubicFractal;
        break;
      case 'Perlin':
        noiseType = NoiseType.perlin;
        break;
      case 'PerlinFractal':
        noiseType = NoiseType.perlinFractal;
        break;
      case 'Simplex':
        noiseType = NoiseType.simplex;
        break;
      case 'SimplexFractal':
        noiseType = NoiseType.simplexFractal;
        break;
      case 'Value':
        noiseType = NoiseType.value;
        break;
      case 'ValueFractal':
        noiseType = NoiseType.valueFractal;
        break;
      case 'WhiteNoise':
        noiseType = NoiseType.whiteNoise;
        break;
    }

    switch (fractalTypeSelect!.value) {
      case 'FBM':
        fractalType = FractalType.fbm;
        break;
      case 'Billow':
        fractalType = FractalType.billow;
        break;
      case 'RigidMulti':
        fractalType = FractalType.rigidMulti;
        break;
    }

    switch (interpTypeSelect!.value) {
      case 'Hermite':
        interp = Interp.hermite;
        break;
      case 'Linear':
        interp = Interp.linear;
        break;
      case 'Quintic':
        interp = Interp.quintic;
        break;
    }

    switch (cellRetTypeSelect!.value) {
      case 'Distance':
        cellularReturnType = CellularReturnType.distance;
        break;
      case 'Distance2Add':
        cellularReturnType = CellularReturnType.distance2Add;
        break;
      case 'Distance2':
        cellularReturnType = CellularReturnType.distance2;
        break;
      case 'Distance2Div':
        cellularReturnType = CellularReturnType.distance2Div;
        break;
      case 'Distance2Mul':
        cellularReturnType = CellularReturnType.distance2Mul;
        break;
      case 'Distance2Sub':
        cellularReturnType = CellularReturnType.distance2Sub;
        break;
      case 'CellValue':
        cellularReturnType = CellularReturnType.cellValue;
        break;
    }

    switch (cellDistFnSelect!.value) {
      case 'Natural':
        cellularDistanceFunction = CellularDistanceFunction.natural;
        break;
      case 'Euclidean':
        cellularDistanceFunction = CellularDistanceFunction.euclidean;
        break;
      case 'Manhattan':
        cellularDistanceFunction = CellularDistanceFunction.manhattan;
        break;
    }

    render(
      noise2(
        size,
        size,
        seed: seed,
        frequency: freq as double,
        gain: gain as double,
        octaves: octaves,
        fractalType: fractalType!,
        interp: interp!,
        cellularReturnType: cellularReturnType!,
        cellularDistanceFunction: cellularDistanceFunction!,
        lacunarity: lacunarity as double,
        noiseType: noiseType!,
      ),
      size,
      size,
    );
  });
}

void render(List<List<double>> map, int w, int h) {
  final container = querySelector('#canvas-container')!;
  final canvas = CanvasElement(width: w, height: h);
  final context = canvas.getContext('2d')! as CanvasRenderingContext2D;
  final imageData = context.createImageData(w, h);

  for (var x = 0; x < w; x++) {
    for (var y = 0; y < h; y++) {
      final s = 4 * (y * h + x);
      final value = (128 + 128 * map[x][y]).floor();

      imageData.data[s] = imageData.data[s + 1] = imageData.data[s + 2] = value;
      imageData.data[s + 3] = 255;
    }
  }

  context.putImageData(imageData, 0, 0, 0, 0, w, h);

  if (container.children.isNotEmpty) {
    container.children.first.remove();
  }

  container.append(canvas);
}
