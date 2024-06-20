import 'package:flutter/material.dart';
import 'package:flutter_application_calculator_app/colors.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalcualatorApp(),
      title: 'Calculator App',
    );
  }
}

class CalcualatorApp extends StatefulWidget {
  const CalcualatorApp({super.key});

  @override
  State<CalcualatorApp> createState() => _CalcualatorAppState();
}

class _CalcualatorAppState extends State<CalcualatorApp> {
  // variables
  double firstnum = 0.0;
  double secnum = 0.0;
  var input = '';
  var output = '';
  var operation = '';
  var hideinput = false;
  var outputsize = 34.0;

  onbuttonclick(value) {
    // value AC then reset
    if (value == 'AC') {
      input = '';
      output = '';
    } else if (value == '<') {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    } else if (value == '=') {
      var userinput = input;
      userinput = input.replaceAll('X', '*');
      Parser p = Parser(); // For Mathematical Calculations
      Expression expression = p.parse(userinput);
      ContextModel cm = ContextModel();
      var finalvalue = expression.evaluate(EvaluationType.REAL, cm);
      output = finalvalue.toString();
      if (output.endsWith('.0')) {
        output = output.substring(0, output.length - 2);
      }
      input = output;
      hideinput = true;
    } else {
      input = input + value;
      hideinput = false;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
              child: Container(
            padding: const EdgeInsets.all(12),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  hideinput
                      ? ''
                      : input, // Using Ternary Operator To hide Input
                  style: const TextStyle(fontSize: 48.0, color: Colors.white),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  output,
                  style: TextStyle(fontSize: outputsize, color: Colors.white),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          )),
          //Button Area
          Row(
            children: [
              button(text: 'AC', buttonbgColor: orangeColor),
              button(text: '<', textColor: orangeColor),
              button(text: '', buttonbgColor: Colors.transparent),
              button(text: '/', textColor: orangeColor)
            ],
          ),
          Row(
            children: [
              button(
                text: '7',
              ),
              button(text: '8'),
              button(
                text: '9',
              ),
              button(
                  text: 'X',
                  textColor: orangeColor,
                  buttonbgColor: operatorColor)
            ],
          ),
          Row(
            children: [
              button(
                text: '4',
              ),
              button(text: '5'),
              button(
                text: '6',
              ),
              button(
                  text: '-',
                  textColor: orangeColor,
                  buttonbgColor: operatorColor)
            ],
          ),
          Row(
            children: [
              button(
                text: '1',
              ),
              button(text: '2'),
              button(
                text: '3',
              ),
              button(
                  text: '+',
                  textColor: orangeColor,
                  buttonbgColor: operatorColor)
            ],
          ),
          Row(
            children: [
              button(
                  text: '%',
                  textColor: orangeColor,
                  buttonbgColor: operatorColor),
              button(
                  text: '0',
                  textColor: orangeColor,
                  buttonbgColor: operatorColor),
              button(
                  text: '.',
                  textColor: orangeColor,
                  buttonbgColor: operatorColor),
              button(text: '=', buttonbgColor: orangeColor)
            ],
          )
        ],
      ),
    );
  }

// Here Widget is the Function
  Widget button({
    text,
    textColor = Colors.white,
    buttonbgColor = const Color(0xff191919),
  }) {
    return Expanded(
        child: Container(
            margin: const EdgeInsets.all(8),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(22),
                    backgroundColor: buttonbgColor),
                onPressed: () => onbuttonclick(text),
                child: Text(
                  text,
                  style: TextStyle(
                      fontSize: 18,
                      color: textColor,
                      fontWeight: FontWeight.bold),
                ))));
  }
}
