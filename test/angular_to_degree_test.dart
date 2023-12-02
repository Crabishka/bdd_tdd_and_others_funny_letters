import 'package:flutter_test/flutter_test.dart';
import 'package:given_when_then_unit_test/given_when_then_unit_test.dart';
import 'package:mockito/annotations.dart';
import 'package:shouldly/shouldly.dart';
import 'dart:math' as math;
import 'package:test_tdd/feature/convertion/converter_util.dart';
import 'package:test_tdd/feature/convertion/domain/angular_measure.dart';
import 'package:test_tdd/feature/convertion/domain/degree_measure.dart';

@GenerateMocks([ConvertUtil])
void main() {
  final converter = ConvertUtil();


  bool conversionRight(DegreeMeasure result, DegreeMeasure expected) {
    final conversionInaccuracy = result - expected;
    if (conversionInaccuracy.degrees != 0) {
      return false;
    }
    if (conversionInaccuracy.minutes.abs() > 3) {
      return false;
    }
    if (conversionInaccuracy.seconds.abs() > 36 && conversionInaccuracy.minutes.abs() == 3) {
      return false;
    }
    return true;
  }

  /// step 1 - заставляю тесты хотя бы запуститься
  /// step 2 - написание реализации
  /// step 3 - проверка на простейших данных
  /// step 4 - больше половины тестов упало
  /// step 5 - решение проблемы с погрешностью перевода
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
      given('Given angular measure is ${testCase.arg2.toString()}', () {
        DegreeMeasure? result;

        when('Conversion is starting ', () {
          result = converter.convertAngularIntoDegree(testCase.arg2);
        });

        then('Degree measure should be ${testCase.arg1}, get $result', () {
          conversionRight(result!, testCase.arg1).should.as('degree measure').be(true);
        });
      });
    });
  });


}
