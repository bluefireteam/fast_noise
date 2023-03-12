import 'package:fast_noise/fast_noise.dart';
import 'package:test/test.dart';

const int _testSeed = 6733;

List<double> generateNoise2(Noise2 noise) {
  return List.generate(
    10,
    (i) => noise.getNoise2(i / 10.0, 0.5),
  );
}

void main() {
  group('noise2', () {
    test('cellular', () {
      final cellular = CellularNoise(
        seed: _testSeed,
        frequency: 10,
      );

      final noise = generateNoise2(cellular);
      expect(
        noise,
        [
          -0.5606826762668788,
          0.5596685521304607,
          0.6789395469240844,
          -0.5334615409374237,
          0.40710080275312066,
          0.3889498896896839,
          0.046528065111488104,
          -0.320906400680542,
          0.9886587900109589,
          -0.13394099846482277,
        ],
      );
    });
    test('cubic', () {
      final cubic = CubicNoise(
        seed: _testSeed,
        frequency: 10,
      );

      final noise = generateNoise2(cubic);
      expect(
        noise,
        [
          0.1504448784722222,
          -0.20471556670963764,
          0.05000376535786522,
          -0.39961485957933796,
          -0.10863453812069362,
          0.10875494343539079,
          0.21939932803312936,
          0.39972854177984923,
          0.14287047915988496,
          -0.34935507695708007,
        ],
      );
    });
    test('cubic fractal', () {
      final cubicFractal = CubicFractalNoise(
        seed: _testSeed,
        frequency: 10,
      );

      final noise = generateNoise2(cubicFractal);
      expect(
        noise,
        [
          0.24260554542498927,
          -0.15233087518976793,
          -0.03733301071065759,
          -0.21549469826831702,
          0.06117060517389623,
          0.17656351291825845,
          0.1662723606245385,
          0.14695444061524335,
          0.03188425985475381,
          -0.19411983544982608,
        ],
      );
    });
    test('perlin', () {
      final perlin = PerlinNoise(
        seed: _testSeed,
        interp: Interp.linear,
        frequency: 0.2,
      );

      final noise = generateNoise2(perlin);
      expect(
        noise,
        [
          -0.18000000000000002,
          -0.196,
          -0.21120000000000003,
          -0.22560000000000002,
          -0.23920000000000002,
          -0.252,
          -0.264,
          -0.2752,
          -0.2856,
          -0.2952,
        ],
      );
    });
    test('perlin fractal', () {
      final perlinFractal = PerlinFractalNoise(
        seed: _testSeed,
        interp: Interp.linear,
        frequency: 0.2,
      );

      final noise = generateNoise2(perlinFractal);
      expect(
        noise,
        [
          -0.1942857142857143,
          -0.19044571428571427,
          -0.18852571428571427,
          -0.1885257142857143,
          -0.19044571428571427,
          -0.19428571428571426,
          -0.20004571428571427,
          -0.2077257142857143,
          -0.2173257142857143,
          -0.22884571428571432,
        ],
      );
    });
    test('simplex', () {
      final simplex = SimplexNoise(
        seed: _testSeed,
        frequency: 10,
      );

      final noise = generateNoise2(simplex);
      expect(
        noise,
        [
          0.0,
          0.0,
          -0.494384765625,
          0.0,
          -0.98876953125,
          0.0,
          -0.494384765625,
          0.0,
          0.7415771484375,
          0.0,
        ],
      );
    });
    test('simplex fractal', () {
      final simplexFractal = SimplexFractalNoise(
        seed: _testSeed,
        frequency: 10,
      );

      final noise = generateNoise2(simplexFractal);
      expect(
        noise,
        [
          0.0,
          0.0,
          -0.28250558035714285,
          0.0,
          -0.5650111607142857,
          0.0,
          -0.28250558035714285,
          0.0,
          0.42375837053571425,
          0.0,
        ],
      );
    });
    test('value', () {
      final value = ValueNoise(
        seed: _testSeed,
        frequency: 10,
      );

      final noise = generateNoise2(value);
      expect(
        noise,
        [
          0.3385009765625,
          -0.4606100250966847,
          0.11250847205519676,
          -0.8991334340535104,
          -0.24442771077156067,
          0.24469862272962928,
          0.4936484880745411,
          0.8993892190046608,
          0.3214585781097412,
          -0.7860489231534302,
        ],
      );
    });
    test('value fractal', () {
      final valueFractal = ValueFractalNoise(
        seed: _testSeed,
        frequency: 10,
      );

      final noise = generateNoise2(valueFractal);
      expect(
        noise,
        [
          0.5458624772062258,
          -0.3427444691769779,
          -0.08399927409897957,
          -0.4848630711037133,
          0.1376338616412665,
          0.39726790406608153,
          0.3741128114052117,
          0.3306474913842976,
          0.07173958467319608,
          -0.4367696297621088,
        ],
      );
    });
    test('white', () {
      final white = WhiteNoise(
        seed: _testSeed,
        frequency: 10,
      );

      final noise = generateNoise2(white);
      expect(
        noise,
        [
          0.3385009765625,
          -0.4606100250966847,
          0.11250847205519676,
          -0.8991334340535104,
          -0.24442771077156067,
          0.24469862272962928,
          0.4936484880745411,
          0.8993892190046608,
          0.3214585781097412,
          -0.7860489231534302,
        ],
      );
    });
  });
}
