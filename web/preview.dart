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
    final size = int.parse(sizeInput!.value!),
        seed = int.parse(seedInput!.value!),
        freq = double.parse(freqInput!.value!) as int,
        gain = double.parse(gainInput!.value!) as int,
        lacunarity = double.parse(lacunarityInput!.value!) as int,
        octaves = int.parse(octavesInput!.value!);
    NoiseType? noiseType;
    FractalType? fractalType;
    Interp? interp;
    CellularReturnType? cellularReturnType;
    CellularDistanceFunction? cellularDistanceFunction;

    switch (noiseTypeSelect!.value) {
      case 'Cellular':
        noiseType = NoiseType.Cellular;
        break;
      case 'Cubic':
        noiseType = NoiseType.Cubic;
        break;
      case 'CubicFractal':
        noiseType = NoiseType.CubicFractal;
        break;
      case 'Perlin':
        noiseType = NoiseType.Perlin;
        break;
      case 'PerlinFractal':
        noiseType = NoiseType.PerlinFractal;
        break;
      case 'Simplex':
        noiseType = NoiseType.Simplex;
        break;
      case 'SimplexFractal':
        noiseType = NoiseType.SimplexFractal;
        break;
      case 'Value':
        noiseType = NoiseType.Value;
        break;
      case 'ValueFractal':
        noiseType = NoiseType.ValueFractal;
        break;
      case 'WhiteNoise':
        noiseType = NoiseType.WhiteNoise;
        break;
    }

    switch (fractalTypeSelect!.value) {
      case 'FBM':
        fractalType = FractalType.FBM;
        break;
      case 'Billow':
        fractalType = FractalType.Billow;
        break;
      case 'RigidMulti':
        fractalType = FractalType.RigidMulti;
        break;
    }

    switch (interpTypeSelect!.value) {
      case 'Hermite':
        interp = Interp.Hermite;
        break;
      case 'Linear':
        interp = Interp.Linear;
        break;
      case 'Quintic':
        interp = Interp.Quintic;
        break;
    }

    switch (cellRetTypeSelect!.value) {
      case 'Distance':
        cellularReturnType = CellularReturnType.Distance;
        break;
      case 'Distance2Add':
        cellularReturnType = CellularReturnType.Distance2Add;
        break;
      case 'Distance2':
        cellularReturnType = CellularReturnType.Distance2;
        break;
      case 'Distance2Div':
        cellularReturnType = CellularReturnType.Distance2Div;
        break;
      case 'Distance2Mul':
        cellularReturnType = CellularReturnType.Distance2Mul;
        break;
      case 'Distance2Sub':
        cellularReturnType = CellularReturnType.Distance2Sub;
        break;
      case 'CellValue':
        cellularReturnType = CellularReturnType.CellValue;
        break;
    }

    switch (cellDistFnSelect!.value) {
      case 'Natural':
        cellularDistanceFunction = CellularDistanceFunction.Natural;
        break;
      case 'Euclidean':
        cellularDistanceFunction = CellularDistanceFunction.Euclidean;
        break;
      case 'Manhattan':
        cellularDistanceFunction = CellularDistanceFunction.Manhattan;
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
