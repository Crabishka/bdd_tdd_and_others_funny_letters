import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:rxdart/rxdart.dart';
import 'package:test_tdd/feature/convertion/converter_util.dart';
import 'package:test_tdd/feature/convertion/domain/angular_measure.dart';
import 'package:test_tdd/feature/convertion/domain/degree_measure.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController degreeController = TextEditingController();
  final TextEditingController angularController = TextEditingController();
  final ConvertUtil convertUtil = ConvertUtil();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Секретная военная разработка',
          style: TextStyle(
            fontSize: 24,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Ввод значений угомера осуществяется 2 цифрами больших делений и 2 цифрами малых делений.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 60,
              child: TextField(
                controller: angularController,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1),
                  ),
                  hintText: 'Введите значение градусной меры',
                ),
                keyboardType: TextInputType.phone,
                onChanged: (value) {
                  final splitted = value.split('-');
                  final largeDivision =
                      splitted.isNotEmpty ? int.parse(splitted.first) : 0;

                  int smallDivision =
                      splitted.length > 1 ? int.parse(splitted[1]) : 0;

                  final angular = AngularMeasure(
                      largeDivision: largeDivision,
                      smallDivision: smallDivision);
                  final degree = convertUtil.convertAngularIntoDegree(angular);
                  degreeController.text = degree.toString();
                },
                inputFormatters: [
                  angularFormatter,
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                height: 40,
                width: double.infinity,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.greenAccent,
                  ),
                  child: const Center(
                      child: Text('Измените значения для пересчета')),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 60,
              child: TextField(
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1),
                  ),
                  hintText: 'Введите значение градусной меры',
                ),
                controller: degreeController,
                keyboardType: TextInputType.phone,
                onChanged: (value) {
                  final splitted = value.split('["\'°]');
                  final degree =
                      splitted.isNotEmpty ? int.parse(splitted.first) : 0;

                  int minutes =
                      splitted.length > 1 ? int.parse(splitted[1]) : 0;

                  int seconds =
                      splitted.length > 1 ? int.parse(splitted[2]) : 0;

                  final degrees = DegreeMeasure(degrees: degree, minutes: minutes, seconds: seconds);
                  final angular = convertUtil.convertDegreeIntoAngular(degrees);

                  angularController.text = angular.toString();
                },
                inputFormatters: [
                  degreesFormatter,
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              'Ввод градусной меры осуществляется 3 цифрами градусной меры, 2 цифрами градусных минут и 2 цифр необязательных секунд.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const Spacer(),
            SizedBox(
              height: 60,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent,
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  'История конвертаций',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            )
          ],
        ),
      ),
    );
  }
}

var angularFormatter = MaskTextInputFormatter(
    mask: '##-##',
    filter: {"#": RegExp(r'[0-9]'), '&': RegExp(r'[0-6]')},
    type: MaskAutoCompletionType.lazy);

var degreesFormatter = MaskTextInputFormatter(
    mask: '###°&#\'&#"',
    filter: {"#": RegExp(r'[0-9]'), '&': RegExp(r'[0-5]')},
    type: MaskAutoCompletionType.lazy);
