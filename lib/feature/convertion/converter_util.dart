
import 'package:mockito/annotations.dart';
import 'package:test_tdd/feature/convertion/domain/angular_measure.dart';
import 'package:test_tdd/feature/convertion/domain/degree_measure.dart';
import 'package:test_tdd/feature/convertion/exception/incorrect_degree_exception.dart';

@GenerateNiceMocks([MockSpec<ConvertUtil>()])
import 'converter_util.mocks.dart';

class ConvertUtil {
  AngularMeasure convertDegreeIntoAngular(DegreeMeasure degreeMeasure) {
    if (degreeMeasure.degrees > 999 ||
        degreeMeasure.degrees < 0 ||
        degreeMeasure.seconds < 0 ||
        degreeMeasure.seconds > 59 ||
        degreeMeasure.minutes < 0 ||
        degreeMeasure.minutes > 59) {
      throw (IncorrectDegreeException());
    }
    int largeDivision = degreeMeasure.degrees ~/ 6;
    int smallDivision =
    ((degreeMeasure.degrees % 6 * 60 + degreeMeasure.minutes + (degreeMeasure.seconds >= 30 ? 1 : 0)) / 3.6).round();
    if (smallDivision == 100) {
      largeDivision += 1;
      smallDivision = 0;
    }
    return AngularMeasure(largeDivision: largeDivision, smallDivision: smallDivision);
  }


  DegreeMeasure convertAngularIntoDegree(AngularMeasure angularMeasure) {
    if (angularMeasure.largeDivision > 90 ||
        angularMeasure.largeDivision < 0 ||
        angularMeasure.smallDivision < 0 ||
        angularMeasure.smallDivision > 99 ) {
      throw (IncorrectDegreeException());
    }
    int degrees = angularMeasure.largeDivision * 6 + angularMeasure.smallDivision * 3.6 ~/ 60;
    // одно малое деление это 3'36'' или 216"
    int seconds = angularMeasure.smallDivision * 216;
    int minutes = seconds ~/ 60;
    seconds = seconds % 60;
    minutes = minutes % 60;
    return DegreeMeasure(degrees: degrees, minutes: minutes, seconds: seconds);
  }
}
