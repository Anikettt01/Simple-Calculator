import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

import 'Colors.dart';

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  double Firstnum = 0.0;
  double Secondnum = 0.0;
  var input = '';
  var output = '';
  var operation = '';
  var hideInput = false;
  var outputSize = 34.0;

  onButtonClick(value) {
    if (value == "C") {
      input = '';
      output = '';
    } else if (value == "⌫") {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    } else if (value == "=") {
      if (input.isNotEmpty) {
        var userInput = input;
        userInput = input.replaceAll("×", "*");
        Parser p = Parser();
        Expression expression = p.parse(userInput);
        ContextModel cm = ContextModel();
        var finalValue = expression.evaluate(EvaluationType.REAL, cm);
        output = finalValue.toString();
        if (output.endsWith(".0")) {
          output = output.substring(0, output.length - 2);
        }
        input = output;
        hideInput = true;
        outputSize = 52;
      }
    } else {
      input = input + value;
      hideInput = false;
      outputSize = 34;
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
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  color: Colors.black,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        hideInput ? '' : input,
                        style: TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        output,
                        style: TextStyle(
                          fontSize: outputSize,
                          color: Colors.white.withOpacity(0.7),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                )),
            Row(
              children: [
                button(text: "C", buttonBg: operatorColor),
                button(text: "%", buttonBg: operatorColor),
                button(text: "⌫", buttonBg: operatorColor),
                button(text: "/", buttonBg: operatorColor)
              ],
            ),
            Row(
              children: [
                button(text: "7"),
                button(text: "8"),
                button(text: "9"),
                button(text: "×", buttonBg: operatorColor)
              ],
            ),
            Row(
              children: [
                button(text: "4"),
                button(text: "5"),
                button(text: "6"),
                button(text: "-", buttonBg: operatorColor)
              ],
            ),
            Row(
              children: [
                button(text: "1"),
                button(text: "2"),
                button(text: "3"),
                button(text: "+", buttonBg: operatorColor)
              ],
            ),
            Row(
              children: [
                button(text: "00"),
                button(text: "0"),
                button(text: "."),
                button(
                  text: "=",
                  buttonBg: equalColor,
                )
              ],
            ),
          ],
        ));
  }

  Widget button(
      {text, tColor = Colors.white, buttonBg = buttonColor, fontSize = 20}) {
    return Expanded(
        child: Container(
            margin: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: const EdgeInsets.all(22),
                  primary: buttonBg),
              onPressed: () => onButtonClick(text),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 20,
                  color: tColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )));
  }
}
