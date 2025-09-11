import 'package:flutter/material.dart';
import 'package:tugas1_pam/pages/navbar.dart';
import 'package:tugas1_pam/components/my_button.dart';
import 'package:tugas1_pam/components/my_textfield.dart';

class DigitCounterPage extends StatefulWidget {
  const DigitCounterPage({super.key});

  @override
  State<DigitCounterPage> createState() => _DigitCounterPageState();
}

class _DigitCounterPageState extends State<DigitCounterPage> {
  final TextEditingController numberController = TextEditingController();
  String result = "";

  void countDigits() {
    String input = numberController.text.trim();

    if (input.isEmpty) {
      setState(() {
        result = "Please enter a number";
      });
      return;
    }

    // hanya hitung digit (angka 0-9) dalam input
    int digitCount = input.replaceAll(RegExp(r'[^0-9]'), '').length;

    setState(() {
      result = "Total digits: $digitCount";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Navbar(),
      appBar: AppBar(),
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyTextField(
              controller: numberController,
              hintText: "Count numbers",
              obscureText: false,
            ),
            const SizedBox(height: 20),
            MyButton(onTap: countDigits, text: "Check",),
            const SizedBox(height: 20),
            Text(
              result,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, ),
            ),
          ],
        ),
      ),
    );
  }
}
