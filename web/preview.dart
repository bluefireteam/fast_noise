import 'dart:html';

import 'package:fast_noise/fast_noise.dart';

void main() {
  var sizeInput = querySelector('#input-size') as InputElement;
  var seedInput = querySelector('#input-seed') as InputElement;
  var freqInput = querySelector('#input-freq') as InputElement;
  var gainInput = querySelector('#input-gain') as InputElement;
  var lacunarityInput = querySelector('#input-lacunarity') as InputElement;
  var octavesInput = querySelector('#input-octaves') as InputElement;

  var noiseTypeSelect = querySelector('#select-noise-type') as SelectElement;
  var fractalTypeSelect =
      querySelector('#select-fractal-type') as SelectElement;
  var interpTypeSelect = querySelector('#select-interp') as SelectElement;
  var cellDistFnSelect =
      querySelector('#select-cellular-distance-fnc') as SelectElement;
  var cellRetTypeSelect =
      querySelector('#select-cellular-return-type') as SelectElement;
  var renderButton = querySelector('#render-now');

  renderButton.onClick.listen((_) {
    final size = int.parse(sizeInput.value),
        seed = int.parse(seedInput.value),
        freq = double.parse(freqInput.value),
        gain = double.parse(gainInput.value),
        lacunarity = double.parse(lacunarityInput.value),
        octaves = int.parse(octavesInput.value);
    NoiseType noiseType;
    FractalType fractalType;
    Interp interp;
    CellularReturnType cellularReturnType;
    CellularDistanceFunction cellularDistanceFunction;

    switch (noiseTypeSelect.value) {
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

    switch (fractalTypeSelect.value) {
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

    switch (interpTypeSelect.value) {
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

    switch (cellRetTypeSelect.value) {
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

    switch (cellDistFnSelect.value) {
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
        noise2(size, size,
            seed: seed,
            frequency: freq,
            gain: gain,
            octaves: octaves,
            fractalType: fractalType,
            interp: interp,
            cellularReturnType: cellularReturnType,
            cellularDistanceFunction: cellularDistanceFunction,
            lacunarity: lacunarity,
            noiseType: noiseType),
        size,
        size);
  });
}

void render(List<List<double>> map, int w, int h) {
  final container = querySelector('#canvas-container');
  final canvas = new CanvasElement(width: w, height: h);
  final context = canvas.getContext('2d') as CanvasRenderingContext2D;
  final imageData = context.createImageData(w, h);

  for (int x = 0; x < w; x++) {
    for (int y = 0; y < h; y++) {
      var s = 4 * (y * h + x);
      var value = (128 + 128 * map[x][y]).floor();

      imageData.data[s] = imageData.data[s + 1] = imageData.data[s + 2] = value;
      imageData.data[s + 3] = 255;
    }
  }

  context.putImageData(imageData, 0, 0, 0, 0, w, h);

  if (container.children.isNotEmpty) container.children.first.remove();

  container.append(canvas);
}
