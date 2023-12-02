import 'package:given_when_then_unit_test/given_when_then_unit_test.dart';
import 'package:mockito/annotations.dart';
import 'package:shouldly/shouldly.dart';
import 'package:test_tdd/feature/convertion/converter_util.dart';
import 'package:test_tdd/feature/convertion/domain/angular_measure.dart';
import 'package:test_tdd/feature/convertion/domain/degree_measure.dart';

@GenerateMocks([ConvertUtil])
void main() {
  final converter = ConvertUtil();

  /// step 1 - заставляю тесты хотя бы запуститься
  /// step 2 - написание реализации
  /// step 3 - проверка на простейших данных
  /// step 4 - проверка на пограничных случаях
  /// step 5 - нашлась ошибка при секундах и минутах > 59 и при секундах и минутах == 59
  /// step 6 - пофикшен баг при секундах и минутах >= 59
  /// step 7 - добавлены еще случайные тесты
  /// step 8 - тест упал на некорректных значениях
  /// step 9 - добавлена обработки ошибки для некорретных значений
  /// step 10 - добавлена проверка, что это именна та ошибка
  /// step 11 - добавлены еще случаи для каждого некорректного значения
  /// step 12 - проверка на некорректные значения вынесена в отдельную группу тестов
  /// step 12.1 - вынес в отдельный файл
  given('degree to angular conversion test', () {
    testCases2<DegreeMeasure, AngularMeasure>([
      TestCase2(
        DegreeMeasure(degrees: 0, minutes: 0, seconds: 0),
        AngularMeasure(largeDivision: 0, smallDivision: 0),
      ),
      TestCase2(
        DegreeMeasure(degrees: 294, minutes: 37, seconds: 51),
        AngularMeasure(largeDivision: 49, smallDivision: 11),
      ),
      TestCase2(
        DegreeMeasure(degrees: 360, minutes: 0, seconds: 0),
        AngularMeasure(largeDivision: 60, smallDivision: 0),
      ),
      TestCase2(
        DegreeMeasure(degrees: 540, minutes: 59, seconds: 59),
        AngularMeasure(largeDivision: 90, smallDivision: 17),
      ),
      TestCase2(
        DegreeMeasure(degrees: 179, minutes: 59, seconds: 59),
        AngularMeasure(largeDivision: 30, smallDivision: 0),
      ),
      TestCase2(
        DegreeMeasure(degrees: 0, minutes: 59, seconds: 0),
        AngularMeasure(largeDivision: 0, smallDivision: 16),
      ),
      TestCase2(
        DegreeMeasure(degrees: 0, minutes: 59, seconds: 30),
        AngularMeasure(largeDivision: 0, smallDivision: 17),
      ),
      TestCase2(
        DegreeMeasure(degrees: 0, minutes: 59, seconds: 29),
        AngularMeasure(largeDivision: 0, smallDivision: 16),
      ),
      TestCase2(
        DegreeMeasure(degrees: 174, minutes: 44, seconds: 38),
        AngularMeasure(largeDivision: 29, smallDivision: 13),
      ),
    ], (testCase) {
      given('Given degree measure is ${testCase.arg1.toString()}', () {
        AngularMeasure? result;

        when('Conversion is starting ', () {
          result = converter.convertDegreeIntoAngular(testCase.arg1);
        });

        then('Angular measure should be ${testCase.arg2}', () {
          result?.should.as('angular measure').be(testCase.arg2);
        });
      });
    });
  });
}
