import 'package:fast_noise/fast_noise.dart';
import 'package:test/test.dart';

const int _testSeed = 6733;

List<double> generateNoise3(Noise3 noise) {
  return List.generate(
    10,
    (i) => noise.getNoise3(0.5, 0.5, i / 10.0),
  );
}

void main() {
  group('noise3', () {
    test('cellular', () {
      final cellular = CellularNoise(
        seed: _testSeed,
        frequency: 10,
      );

      final noise = generateNoise3(cellular);
      expect(
        noise,
        [
          0.3889498896896839,
          0.698984342161566,
          0.9274088442325592,
          -0.15004420327022672,
          -0.9904194362461567,
          0.8045992744155228,
          -0.08904457092285156,
          0.3723962469957769,
          0.7161240316927433,
          0.6152727366425097,
        ],
      );
    });
    test('cubic', () {
      final cubic = CubicNoise(
        seed: _testSeed,
        frequency: 10,
      );

      final noise = generateNoise3(cubic);
      expect(
        noise,
        [
          0.07250329562359385,
          -0.023762835396660697,
          -0.0643015739818414,
          -0.2961814370420244,
          -0.07442269736418017,
          0.2651990961145472,
          0.07010315538004593,
          0.14526414540078905,
          0.0753954840755021,
          -0.11872031070567943,
        ],
      );
    });
    test('cubic fractal', () {
      final cubicFractal = CubicFractalNoise(
        seed: _testSeed,
        frequency: 10,
      );

      final noise = generateNoise3(cubicFractal);
      expect(
        noise,
        [
          0.1177090086121723,
          -0.03455847298736294,
          -0.12856830950215378,
          -0.2044459512191159,
          -0.028076363481068733,
          0.15925922230989842,
          0.0786171556898841,
          0.12606548283387112,
          0.03341858741388749,
          -0.15742529717781553,
        ],
      );
    });
    test('perlin', () {
      final perlin = PerlinNoise(
        seed: _testSeed,
        interp: Interp.Linear,
        frequency: 0.2,
      );

      final noise = generateNoise3(perlin);
      expect(
        noise,
        [
          0.081,
          0.09368800000000001,
          0.10579200000000001,
          0.117312,
          0.128248,
          0.1386,
          0.14836800000000003,
          0.15755199999999997,
          0.166152,
          0.174168,
        ],
      );
    });
    test('perlin fractal', () {
      final perlinFractal = PerlinFractalNoise(
        seed: _testSeed,
        interp: Interp.Linear,
        frequency: 0.2,
      );

      final noise = generateNoise3(perlinFractal);
      expect(
        noise,
        [
          0.03714285714285716,
          0.07833142857142857,
          0.11574857142857144,
          0.1493942857142857,
          0.17926857142857144,
          0.20537142857142857,
          0.22770285714285715,
          0.24626285714285712,
          0.26105142857142855,
          0.2720685714285714,
        ],
      );
    });
    test('simplex', () {
      final simplex = SimplexNoise(
        seed: _testSeed,
        frequency: 10,
      );

      final noise = generateNoise3(simplex);
      expect(
        noise,
        [
          -0.7600995884773667,
          0.7600995884773653,
          0.0,
          0.10787818930040982,
          0.652221399176953,
          0.0,
          0.7600995884773672,
          -0.7600995884773653,
          0.0,
          0.8679777777777771,
        ],
      );
    });
    test('simplex fractal', () {
      final simplexFractal = SimplexFractalNoise(
        seed: _testSeed,
        frequency: 10,
      );

      final noise = generateNoise3(simplexFractal);
      expect(
        noise,
        [
          -0.5429282774838343,
          0.41893145208700655,
          0.0,
          -0.01611863609641333,
          0.43505008818342095,
          0.0,
          0.7446884185773092,
          -0.41893145208700805,
          0.0,
          0.4182239858906527,
        ],
      );
    });
    test('value', () {
      final value = ValueNoise(
        seed: _testSeed,
        frequency: 10,
      );

      final noise = generateNoise3(value);
      expect(
        noise,
        [
          0.24469862272962928,
          -0.08019956946372986,
          -0.21701781218871474,
          -0.9996123500168324,
          -0.2511766036041081,
          0.8950469493865967,
          0.236598149407655,
          0.49026649072766304,
          0.25445975875481963,
          -0.4006810486316681,
        ],
      );
    });
    test('value fractal', () {
      final valueFractal = ValueFractalNoise(
        seed: _testSeed,
        frequency: 10,
      );

      final noise = generateNoise3(valueFractal);
      expect(
        noise,
        [
          0.39726790406608153,
          -0.11663484633234994,
          -0.43391804456976907,
          -0.6900050853645162,
          -0.09475772674860698,
          0.5374998752959073,
          0.2653329004533589,
          0.4254710045643151,
          0.1127877325218703,
          -0.5313103779751275,
        ],
      );
    });
    test('white', () {
      final white = WhiteNoise(
        seed: _testSeed,
        frequency: 10,
      );

      final noise = generateNoise3(white);
      expect(
        noise,
        [
          0.24469862272962928,
          -0.08019956946372986,
          -0.21701781218871474,
          -0.9996123500168324,
          -0.2511766036041081,
          0.8950469493865967,
          0.236598149407655,
          0.49026649072766304,
          0.25445975875481963,
          -0.4006810486316681,
        ],
      );
    });
  });
}
