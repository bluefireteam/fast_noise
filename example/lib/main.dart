import 'dart:math';
import 'dart:ui' as ui;

import 'package:fast_noise/fast_noise.dart';
import 'package:fast_noise_flutter_example/forms/double_field.dart';
import 'package:fast_noise_flutter_example/forms/enum_field.dart';
import 'package:fast_noise_flutter_example/forms/int_field.dart';
import 'package:fast_noise_flutter_example/generator.dart';
import 'package:fast_noise_flutter_example/image_pane.dart';
import 'package:fast_noise_flutter_example/parameter_names.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'fast_noise examples',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _loading = false;
  ui.Image? _image;

  int seed = 1337;
  int width = 512;
  int height = 512;
  NoiseType noiseType = NoiseType.cellular;
  Interp interp = Interp.quintic;
  int octaves = 5;
  double lacunarity = 2.0;
  double gain = .5;
  FractalType fractalType = FractalType.fbm;
  double frequency = 0.015;
  CellularDistanceFunction cellularDistanceFunction =
      CellularDistanceFunction.euclidean;
  CellularReturnType cellularReturnType = CellularReturnType.distance2Add;

  @override
  Widget build(BuildContext context) {
    final validParameters = parametersPerNoiseType[noiseType]!;
    return Scaffold(
      appBar: AppBar(
        title: const Text('fast_noise'),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.blueAccent,
              ),
            ),
            margin: const EdgeInsets.all(16.0),
            padding: const EdgeInsets.all(16.0),
            width: 512,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                IntField(
                  title: 'Seed',
                  value: seed,
                  setValue: (v) => setState(() => seed = v),
                ),
                IntField(
                  title: 'Width (pixels)',
                  value: width,
                  setValue: (v) => setState(() => width = v),
                ),
                IntField(
                  title: 'Height (pixels)',
                  value: height,
                  setValue: (v) => setState(() => height = v),
                ),
                EnumField(
                  title: 'Noise Type',
                  value: noiseType,
                  setValue: (NoiseType v) => setState(() => noiseType = v),
                  values: NoiseType.values,
                ),
                DoubleField(
                  title: 'frequency (double)',
                  value: frequency,
                  setValue: (v) => setState(() => frequency = v),
                ),
                EnumField(
                  title: 'Interp',
                  value: interp,
                  setValue: (v) => setState(() => interp = v),
                  values: Interp.values,
                  enabled: validParameters.contains(ParameterNames.interp),
                ),
                EnumField(
                  title: 'Fractal Type',
                  value: fractalType,
                  setValue: (v) => setState(() => fractalType = v),
                  values: FractalType.values,
                  enabled: validParameters.contains(ParameterNames.fractalType),
                ),
                IntField(
                  title: 'octaves (int)',
                  value: octaves,
                  setValue: (v) => setState(() => octaves = v),
                  enabled: validParameters.contains(ParameterNames.octaves),
                ),
                DoubleField(
                  title: 'gain (double)',
                  value: gain,
                  setValue: (v) => setState(() => gain = v),
                  enabled: validParameters.contains(ParameterNames.gain),
                ),
                DoubleField(
                  title: 'lacunarity (double)',
                  value: lacunarity,
                  setValue: (v) => setState(() => lacunarity = v),
                  enabled: validParameters.contains(ParameterNames.lacunarity),
                ),
                EnumField(
                  title: 'Cellular Dist Func',
                  value: cellularDistanceFunction,
                  setValue: (v) => setState(() => cellularDistanceFunction = v),
                  values: CellularDistanceFunction.values,
                  enabled: validParameters.contains(
                    ParameterNames.cellularDistanceFunction,
                  ),
                ),
                EnumField(
                  title: 'Cellular Ret Type',
                  value: cellularReturnType,
                  setValue: (v) => setState(() => cellularReturnType = v),
                  values: CellularReturnType.values,
                  enabled: validParameters.contains(
                    ParameterNames.cellularDistanceFunction,
                  ),
                ),
                TextButton(
                  child: const Text('Generate'),
                  onPressed: () async {
                    setState(() => _loading = true);
                    final image = await generate(
                      width: width,
                      height: height,
                      seed: seed,
                      noiseType: noiseType,
                      frequency: frequency,
                      interp: interp,
                      octaves: octaves,
                      fractalType: fractalType,
                      gain: gain,
                      lacunarity: lacunarity,
                      cellularDistanceFunction: cellularDistanceFunction,
                      cellularReturnType: cellularReturnType,
                    );
                    setState(() {
                      _image = image;
                      _loading = false;
                    });
                  },
                ),
                TextButton(
                  child: const Text('Re-seed'),
                  onPressed: () {
                    final newSeed = Random().nextInt(100000);
                    setState(() => seed = newSeed);
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.blueAccent,
                ),
              ),
              margin: const EdgeInsets.all(16.0),
              padding: const EdgeInsets.all(16.0),
              child: ImagePane(loading: _loading, image: _image),
            ),
          )
        ],
      ),
    );
  }
}
