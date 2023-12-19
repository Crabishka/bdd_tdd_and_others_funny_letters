import 'package:given_when_then_unit_test/given_when_then_unit_test.dart';
import 'package:shouldly/shouldly.dart';
import 'package:test_tdd/feature/convertion/converter_util.dart';
import 'package:test_tdd/feature/convertion/domain/angular_measure.dart';
import 'package:test_tdd/feature/convertion/domain/degree_measure.dart';
import 'package:test_tdd/feature/convertion/exception/incorrect_degree_exception.dart';
import 'exception_not_caught.dart';

main() {
  final converter = ConvertUtil();
  // TODO(johnyTwoJacket): naming
  given('degree to angular conversion exception test', () {
    testCases1<DegreeMeasure>([
      TestCase1(
        DegreeMeasure(degrees: 174, minutes: 94, seconds: 38),
      ),
      // TestCase1(
      //   DegreeMeasure(degrees: 174, minutes: 34, seconds: 98),
      // ),
      TestCase1(
        DegreeMeasure(degrees: 3412, minutes: 34, seconds: 98),
      ),
      TestCase1(
        DegreeMeasure(degrees: 174, minutes: 94, seconds: -0),
      ),
      TestCase1(
        DegreeMeasure(degrees: 174, minutes: 94, seconds: -38),
      ),
      TestCase1(
        DegreeMeasure(degrees: 174, minutes: -94, seconds: 38),
      ),
      TestCase1(
        DegreeMeasure(degrees: -174, minutes: 94, seconds: 38),
      ),
      TestCase1(
        DegreeMeasure(degrees: 174, minutes: 94, seconds: -0),
      ),
      TestCase1(
        DegreeMeasure(degrees: -174, minutes: 94, seconds: -38),
      ),
      TestCase1(
        DegreeMeasure(degrees: 174, minutes: -94, seconds: 38),
      ),
      TestCase1(
        DegreeMeasure(degrees: -174, minutes: 94, seconds: 38),
      ),
      TestCase1(
        DegreeMeasure(degrees: 174, minutes: 94, seconds: 38),
      ),
      TestCase1(
        DegreeMeasure(degrees: 174, minutes: 34, seconds: 98),
      ),
      TestCase1(
        DegreeMeasure(degrees: 3412, minutes: 34, seconds: 38),
      ),
      TestCase1(DegreeMeasure(degrees: -12, minutes: 34, seconds: 38)),
    ], (testCase) {
      given('Degree measure is ${testCase.arg.toString()}', () {
        AngularMeasure? result;

        when('Conversion is starting ', () {
          // выглядит как костыль
          try {
            result = converter.convertDegreeIntoAngular(testCase.arg);
            then('Exception din\'t catch', () {
              throw (ExceptionNotCaught());
            });
          } catch (e) {
            then('Catch $e', () {
              e.should.as('caught exception').beOfType<IncorrectDegreeException>();
            });
            return;
          }
        });
      });
    });
  });
}
