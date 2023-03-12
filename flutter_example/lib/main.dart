import 'dart:typed_data';

import 'package:fast_noise/fast_noise.dart';
import 'package:flutter/material.dart';

import 'forms/double_field.dart';
import 'forms/enum_field.dart';
import 'forms/int_field.dart';
import 'generator.dart';

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
  Uint8List? _image;

  int seed = 1337;
  int width = 512;
  int height = 512;
  NoiseType noiseType = NoiseType.Cellular;
  int octaves = 5;
  double frequency = 0.015;
  CellularDistanceFunction cellularDistanceFunction =
      CellularDistanceFunction.Euclidean;
  CellularReturnType cellularReturnType = CellularReturnType.Distance2Add;

  @override
  Widget build(BuildContext context) {
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text('Seed $seed'),
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
                IntField(
                  title: 'octaves (int)',
                  value: octaves,
                  setValue: (v) => setState(() => octaves = v),
                ),
                DoubleField(
                  title: 'frequency (double)',
                  value: frequency,
                  setValue: (v) => setState(() => frequency = v),
                ),
                EnumField(
                  title: 'Cellular Dist Func',
                  value: cellularDistanceFunction,
                  setValue: (CellularDistanceFunction v) {
                    setState(() => cellularDistanceFunction = v);
                  },
                  values: CellularDistanceFunction.values,
                ),
                EnumField(
                  title: 'Cellular Ret Type',
                  value: cellularReturnType,
                  setValue: (CellularReturnType v) {
                    setState(() => cellularReturnType = v);
                  },
                  values: CellularReturnType.values,
                ),
                TextButton(
                  child: const Text('Generate'),
                  onPressed: () async {
                    setState(() => _loading = true);
                    final image = generate(
                      width: width,
                      height: height,
                      seed: seed,
                      noiseType: noiseType,
                      octaves: octaves,
                      frequency: frequency,
                      cellularDistanceFunction: cellularDistanceFunction,
                      cellularReturnType: cellularReturnType,
                    );
                    setState(() {
                      _image = image;
                      _loading = false;
                    });
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
              child: Center(
                child: _ImagePane(loading: _loading, image: _image),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _ImagePane extends StatelessWidget {
  final bool loading;
  final Uint8List? image;
  const _ImagePane({required this.loading, required this.image});

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const CircularProgressIndicator();
    }
    final image = this.image;
    if (image == null) {
      return const Text('Click -generate- to generate a new image.');
    } else {
      return Image.memory(image, filterQuality: FilterQuality.high);
    }
  }
}
