import 'package:flutter/material.dart';
import 'package:tugas1_pam/components/my_button.dart';
import 'package:tugas1_pam/components/my_textfield.dart';

class EvenOddPage extends StatefulWidget {
  const EvenOddPage({super.key});

  @override
  State<EvenOddPage> createState() => _EvenOddPageState();
}

class _EvenOddPageState extends State<EvenOddPage> {
  final TextEditingController numberController = TextEditingController();
  String result = "";

  void checkEvenOdd() {
    int? number = int.tryParse(numberController.text);
    setState(() {
      if (number == null) {
        result = "Please enter a integer number";
      } else {
        result = number % 2 == 0
            ? "$number is Even"
            : "$number is Odd";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyTextField(
              controller: numberController,
              hintText: "Enter a number",
              obscureText: false,
            ),
            const SizedBox(height: 20),
            MyButton(onTap: checkEvenOdd),
            const SizedBox(height: 20),
            Text(
              result,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
