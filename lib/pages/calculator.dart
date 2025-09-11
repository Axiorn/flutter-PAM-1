import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugas1_pam/pages/history.dart';

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorApp();
}

class _CalculatorApp extends State<CalculatorApp> {
  String result = "";
  String input = "0";

  final List<String> buttons = [
    "C",
    "⌫",
    "%",
    "÷",
    "7",
    "8",
    "9",
    "*",
    "4",
    "5",
    "6",
    "-",
    "1",
    "2",
    "3",
    "+",
    "↺",
    "0",
    ",",
    "=",
  ];

  final List<String> forbid = ["%", "÷", "*", "-", "+", ","];

  List<String> history = [];

  void initState() {
    super.initState();
    loadHistory();
  }

  void loadHistory() async {
    final prep = await SharedPreferences.getInstance();
    final data = prep.getString('history');

    if (data != null) {
      setState(() {
        history = List<String>.from(jsonDecode(data));
      });
    }
  }

  void buttonHapus(String value) {
    setState(() {
      if (value == "C") {
        input = "0";
        result = "";
        history = [];
      } else if (value == "⌫" && input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
        if (input.isEmpty) {
          input = "0";
        }
      } else {
        input += value;
      }
    });
  }

  String konversiPersen(input) {
    double num = double.tryParse(input) ?? 0;
    if (num == 0) {
      return "Hello World"; // pura pura ga tau
    }
    return (num / 100).toString();
  }

  void buttonAngka(String value) {
    setState(() {
      if (input == "0") {
        input = value;
      } else if (input == "-0") {
        input = "-$value";
      } else if (value == "0" && input.length == 1 && input == "-") {
        input = value;
      } else {
        input += value;
      }
    });
  }

  void notasiMTK(String value) {
    setState(() {
      if (value == ",") {
        final lastnum = input.split(RegExp(r'[-+*÷]')).last;
        if (!lastnum.contains(",")) {
          input += value;
        } else {}
      } else if (forbid.any((value) => input.endsWith(value))) {
        if (input[input.length - 1] != value) {
          input = input.substring(0, input.length - 1) + value;
        } else {
          return;
        }
      } else if (value == "-" && input.length == 1 && input == "0") {
        input = value;
      } else {
        if (value == "%") {
          input = input.replaceAll(",", ".");
          input = konversiPersen(input);
        } else {
          input += value;
        }
      }
    });
  }

  void perhitungan() async {
    String finalResult;
    try {
      String userInput = input;

      String answer = input.replaceAll("÷", "/").replaceAll(",", ".");

      ExpressionParser p = ShuntingYardParser();

      Expression exp = p.parse(answer);

      final evaluator = RealEvaluator();
      final val = evaluator.evaluate(exp);

      setState(() {
        if (val % 1 == 0) {
          finalResult = val.toInt().toString();
        } else {
          finalResult = val.toString();
          finalResult = finalResult.replaceAll(".", ",");
        }
        result = finalResult;

        history.add("$userInput = $finalResult");
      });

      final prep = await SharedPreferences.getInstance();
      prep.setString('history', jsonEncode(history));
    } catch (e) {
      setState(() {
        finalResult = "Kalkulator Meledak";
        result = finalResult;
      });
    }
  }

  void buttonPressed(String value) {
    if (value == "C" || value == "⌫") {
      buttonHapus(value);
    } else if ("0123456789".contains(value)) {
      buttonAngka(value);
    } else if (value == "↺") {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (context) => History()));
    } else if (value == "=") {
      perhitungan();
    } else {
      notasiMTK(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Calculator",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),

      body: Column(
        children: [
          // History
          HistoryWidget(history: history),

          // Input
          InputWidget(input: input),

          // Hasil
          ResultWidget(result: result),

          // Tombol
          Expanded(
            child: ButtonGrid(buttons: buttons, onButtonPressed: buttonPressed),
          ),
        ],
      ),
    );
  }
}

// ===== History Widget =====
class HistoryWidget extends StatelessWidget {
  final List<String> history;

  const HistoryWidget({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 100, right: 8),
      alignment: Alignment.centerRight,
      child: Text(
        history.isNotEmpty ? history.last : "",
        style: Theme.of(
          context,
        ).textTheme.bodyLarge?.copyWith(color: Colors.black, fontSize: 25),
      ),
    );
  }
}

// ===== Result Widget =====
class ResultWidget extends StatelessWidget {
  final String result;

  const ResultWidget({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 8),
      alignment: Alignment.centerRight,
      child: Text(result, style: TextStyle(fontSize: 50)),
    );
  }
}

// ===== Input Widget =====
class InputWidget extends StatelessWidget {
  final String input;

  const InputWidget({super.key, required this.input});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 8),
      alignment: Alignment.centerRight,
      child: Text(input, style: TextStyle(fontSize: 50)),
    );
  }
}

// ===== Grid Tombol =====
class ButtonGrid extends StatelessWidget {
  final List<String> buttons;
  final Function(String) onButtonPressed;

  const ButtonGrid({
    super.key,
    required this.buttons,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 4,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      padding: const EdgeInsets.all(8),
      children: buttons.map((text) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[850],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () => onButtonPressed(text),
          child: Text(
            text,
            style: const TextStyle(fontSize: 30, color: Colors.white),
          ),
        );
      }).toList(),
    );
  }
}
