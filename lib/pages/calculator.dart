import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorApp();
}

class _CalculatorApp extends State<CalculatorApp> {
  String result = "0";

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

  void buttonHapus(String value) {
    setState(() {
      if (value == "C") {
        result = "0";
      } else if (value == "⌫" && result.isNotEmpty) {
        result = result.substring(0, result.length - 1);
        if (result.isEmpty) {
          result = "0";
        }
      } else {
        result += value;
      }
    });
  }

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

  String konversiPersen(result) {
    double num = double.tryParse(result) ?? 0;
    if (num == 0) {
      return "Hello World"; // pura pura ga tau
    }
    return (num / 100).toString();
  }

  void buttonAngka(String value) {
    setState(() {
      if (result.length == 1 && (result == "0" || result == "-0")) {
        result = value;
      } else {
        result += value;
      }
    });
  }

  void notasiMTK(String value) {
    setState(() {
      if (value == ",") {
        final lastnum = result.split(RegExp(r'[-+*÷]')).last;
        if (lastnum.contains(",")) {
          return;
        } else {
          result += value;
        }
      } else if (forbid.any((value) => result.endsWith(value))) {
        if (result[result.length - 1] != value) {
          result = result.substring(0, result.length - 1) + value;
        } else {
          return;
        }
      } else if (value == "-" && result.length == 1 && result == "0") {
        result = value;
      } else if (value == "0" && result.length == 1 && result == "-") {
        result = value;
      } else {
        if (value == "%") {
          result = result.replaceAll(",", ".");
          result = konversiPersen(result);
        } else {
          result += value;
        }
      }
    });
  }

  void perhitungan() async {
    String finalResult;
    try {
      String userInput = result;

      String answer = result.replaceAll("÷", "/").replaceAll(",", ".");

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
      Navigator.pushNamed(context, "/history");
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
        backgroundColor: Color(0xFF090909),
        centerTitle: true,
        title: Text(
          "Calculator",
          style: Theme.of(context).textTheme.headlineLarge,
        )
      ),
      
      body: Column(
        children: [
          // History
          HistoryWidget(history: history),

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
      padding: const EdgeInsets.only(top: 150),
      alignment: Alignment.centerRight,
      child: Text(
        history.isNotEmpty ? history.last : "",
        style: Theme.of(
          context,
        ).textTheme.bodyLarge?.copyWith(color: Colors.white70),
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
      padding: const EdgeInsets.only(right: 16, bottom: 40),
      alignment: Alignment.centerRight,
      child: Text(result, style: Theme.of(context).textTheme.bodyLarge),
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
            style: const TextStyle(fontSize: 20, color: Colors.white),
          ),
        );
      }).toList(),
    );
  }
}
