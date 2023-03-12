# fast_noise

Fast noise is a direct port from the implementations by [Jordan Peck][auburns].
The Dart version currently does not yet leverage SIMD for better performance.

## Usage

fast_noise offers both 2D and 3D noise generation with ``noise2`` and ``noise3``

The following noise types are available:
- [CellularNoise][cellular_noise]
- [CubicNoise][cubic_noise]
- [PerlinNoise][perlin_noise]
- [SimplexNoise][simplex_noise]
- [ValueNoise][value_noise]
- [WhiteNoise][white_noise]

# Demo
Try out some settings [here][preview]

# Examples
## Cellular Noise
    import 'package:fast_noise/fast_noise.dart';

    main() {
      var arr2d = noise2(
          width,
          height,
          noiseType: NoiseType.cellular,
          octaves: 5,
          frequency: 0.015,
          cellularReturnType: CellularReturnType.distance2Add,
      );
    }

![Cellular Noise](https://imgur.com/ajmSxvC.png)

    import 'package:fast_noise/fast_noise.dart';

    main() {
      var arr2d = noise2(
          width,
          height,
          noiseType: NoiseType.perlin,
          octaves: 3,
          frequency: 0.05,
      );
    }

![Perlin Noise](https://imgur.com/vUFS893.png)       

    import 'package:fast_noise/fast_noise.dart';

    main() {
      var arr2d = noise2(
          width,
          height,
          noiseType: NoiseType.simplexFractal,
          octaves: 4,
          frequency: 0.0075,
      );
    }

![Simplex Fractal Noise](https://imgur.com/PRSWv95.png)

You can also call a noise type directly:

      var noise = new ValueNoise(interp: Interp.quintic, octaves: 5);
      // generate 512x512  
      for (int x = 0; x < 512; x++) {
        for (int y = 0; y < 512; y++) {
          noise.singleValueFractalBillow2(x.toDouble(), y.toDouble());
        }
      }

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/frankpepermans/fast_noise/issues
[auburns]: https://github.com/Auburns
[preview]: http://igindo.com/fastnoise
[cellular_noise]: https://github.com/frankpepermans/fast_noise/blob/master/lib/src/noise/cellular.dart
[cubic_noise]: https://github.com/frankpepermans/fast_noise/blob/master/lib/src/noise/cubic.dart
[perlin_noise]: https://github.com/frankpepermans/fast_noise/blob/master/lib/src/noise/perlin.dart
[simplex_noise]: https://github.com/frankpepermans/fast_noise/blob/master/lib/src/noise/simplex.dart
[value_noise]: https://github.com/frankpepermans/fast_noise/blob/master/lib/src/noise/value.dart
[white_noise]: https://github.com/frankpepermans/fast_noise/blob/master/lib/src/noise/white.dart
