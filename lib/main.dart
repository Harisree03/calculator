import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String display = "0";
  String currentInput = "";
  String operator = "";
  double firstOperand = 0;

  void onDigitClick(String digit) {
    setState(() {
      currentInput += digit;
      display = currentInput;
    });
  }

  void onOperatorClick(String op) {
    if (currentInput.isNotEmpty) {
      firstOperand = double.parse(currentInput);
      currentInput = "";
      operator = op;
    }
  }

  void calculateResult() {
    if (currentInput.isNotEmpty) {
      double secondOperand = double.parse(currentInput);
      double result;

      switch (operator) {
        case "+":
          result = firstOperand + secondOperand;
          break;
        case "-":
          result = firstOperand - secondOperand;
          break;
        case "*":
          result = firstOperand * secondOperand;
          break;
        case "/":
          result =
              secondOperand != 0 ? firstOperand / secondOperand : double.nan;
          break;
        default:
          result = 0;
      }

      setState(() {
        display = result.toString();
        currentInput = display;
        operator = "";
        firstOperand = 0;
      });
    }
  }

  void clear() {
    setState(() {
      display = "0";
      currentInput = "";
      operator = "";
      firstOperand = 0;
    });
  }

  Widget buildButton(String buttonText, Color color) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          if (buttonText == "C") {
            clear();
          } else if (buttonText == "=") {
            calculateResult();
          } else if (["+", "-", "*", "/"].contains(buttonText)) {
            onOperatorClick(buttonText);
          } else {
            onDigitClick(buttonText);
          }
        },
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: EdgeInsets.all(20),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            alignment: Alignment.centerRight,
            child: Text(
              display,
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  buildButton("7", Colors.blueAccent),
                  buildButton("8", Colors.blueAccent),
                  buildButton("9", Colors.blueAccent),
                  buildButton("/", Colors.blueAccent),
                ],
              ),
              Row(
                children: [
                  buildButton("4", Colors.blueAccent),
                  buildButton("5", Colors.blueAccent),
                  buildButton("6", Colors.blueAccent),
                  buildButton("*", Colors.blueAccent),
                ],
              ),
              Row(
                children: [
                  buildButton("1", Colors.blueAccent),
                  buildButton("2", Colors.blueAccent),
                  buildButton("3", Colors.blueAccent),
                  buildButton("-", Colors.blueAccent),
                ],
              ),
              Row(
                children: [
                  buildButton("C", Colors.redAccent),
                  buildButton("0", Colors.blueAccent),
                  buildButton("=", Colors.redAccent),
                  buildButton("+", Colors.blueAccent),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
