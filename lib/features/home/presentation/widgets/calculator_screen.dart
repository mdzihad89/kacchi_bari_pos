import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  var result = '0';
  var inputUser = '';

  void buttonPressed(String text) {
    setState(() {
      if ((inputUser.isEmpty && ['+', '-', 'x', '÷', '%'].contains(text)) ||
          (inputUser.isNotEmpty &&
              ['+', '-', 'x', '÷', '%']
                  .contains(inputUser[inputUser.length - 1]) &&
              ['+', '-', 'x', '÷', '%'].contains(text))) {
        return;
      }

      inputUser = inputUser + text;
      if (text == "00") {
        _expressionScrollController.animateTo(
          _expressionScrollController.position.maxScrollExtent + 50,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      } else {
        _expressionScrollController.animateTo(
          _expressionScrollController.position.maxScrollExtent + 25,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Widget getRow(String text1, String text2, String text3, String text4) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RawMaterialButton(
          onPressed: () {
            if (text1 == 'AC') {
              setState(() {
                inputUser = '';
                result = '0';
              });
            } else {
              buttonPressed(text1);
            }
          },
          elevation: 2.0,
          fillColor: getBackgroundColor(text1),
          padding: EdgeInsets.all(text1 == "AC" ? 15.0 : 10.0),
          shape: const CircleBorder(),
          child: Text(
            text1,
            style: TextStyle(
                color: getTextColor(text1),
                fontSize: text1 == "AC" ? 20 : 30,
                fontWeight: FontWeight.bold),
          ),
        ),
        RawMaterialButton(
          onPressed: () {
            if (text2 == 'CE') {
              setState(() {
                if (inputUser.length > 0) {
                  inputUser = inputUser.substring(0, inputUser.length - 1);
                }
              });
            } else {
              buttonPressed(text2);
            }
          },
          elevation: 2.0,
          fillColor: getBackgroundColor(text2),
          padding: EdgeInsets.all(text2 == "CE" ? 15.0 : 10.0),
          shape: const CircleBorder(),
          child: text2 != "CE" ?Text(
            text2,
            style: TextStyle(
              color: getTextColor(text2),
              fontWeight: FontWeight.bold,
              fontSize: text2== "CE" ? 20 : 30,
            ),
          ):const Icon(Icons.backspace_outlined,color: Colors.red,),
        ),
        RawMaterialButton(
          onPressed: () {
            buttonPressed(text3);
          },
          elevation: 2.0,
          fillColor: getBackgroundColor(text3),
          child: Text(
            text3,
            style: TextStyle(
                color: getTextColor(text3),
                fontSize: 30,
                fontWeight: FontWeight.bold),
          ),
          padding: EdgeInsets.all(10.0),
          shape: CircleBorder(),
        ),
        RawMaterialButton(
          onPressed: () {
            if (text4 == '=') {
              Parser parser = Parser();
              String modifiedInput = inputUser
                  .replaceAll('÷', '/')
                  .replaceAll('x', '*')
                  .replaceAll("%", "* 0.01 *");
              Expression expression = parser.parse(modifiedInput);
              ContextModel contextModel = ContextModel();
              double eval =
              expression.evaluate(EvaluationType.REAL, contextModel);

              setState(() {
                result = eval.toString();
              });
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _resultScrollController.animateTo(
                  _resultScrollController.position.maxScrollExtent,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                );
              });
            } else {
              buttonPressed(text4);
            }
          },
          elevation: 2.0,
          fillColor: kAmber,
          padding: EdgeInsets.all(10.0),
          shape: CircleBorder(),
          child: Text(
            text4,
            style: TextStyle(
                fontSize: 30, color: kWhite, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  final ScrollController _expressionScrollController = ScrollController();
  final ScrollController _resultScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 380,
      height: 700,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              height: 80,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
              alignment: Alignment.centerRight,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                controller: _expressionScrollController,
                child: Text(
                  inputUser,
                  style: TextStyle(
                    color: kLightGray,
                    fontSize: 40,
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
            ),
            Container(
              height: 100,
              padding: const EdgeInsets.all(10.0),
              margin: EdgeInsets.only(left: 20, right: 20),
              alignment: Alignment.centerRight,
              child: SingleChildScrollView(
                controller: _resultScrollController,
                scrollDirection: Axis.horizontal,
                child: Text(
                  result,
                  style: TextStyle(
                    color: kWhite,
                    fontSize: 70,
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  getRow('AC', 'CE', '%', '÷'),
                  getRow('1', '2', '3', 'x'),
                  getRow('4', '5', '6', '-'),
                  getRow('7', '8', '9', '+'),
                  getRow('00', '0', '.', '='),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  bool isOperator(String text) {
    var list = ['AC', 'CE', '%'];

    for (var item in list) {
      if (text == item) {
        return true;
      }
    }
    return false;
  }

  Color getBackgroundColor(String text) {
    if (isOperator(text)) {
      return kLightGray;
    } else {
      return kDarkGray;
    }
  }

  bool textOperator(String text) {
    var list = ['AC', 'CE', '%'];

    for (var item in list) {
      if (text == item) {
        return true;
      }
    }
    return false;
  }

  Color getTextColor(String text) {
    if (isOperator(text)) {
      return Colors.black;
    } else {
      return kWhite;
    }
  }
}

final Color kBackground = Color(0xFF121212);
final Color kLightGray = Color(0xFFB7B7B7);
final Color kDarkGray = Color(0xFF414141);
final Color kRed = Color(0xFFB60000);
final Color kAmber = Color(0xFFf7921e);

final Color kBlack = Color(0xFF000000);
final Color kWhite = Color(0xFFFFFFFF);
