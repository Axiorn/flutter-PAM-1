import 'package:flutter/material.dart';
import 'package:tugas1_pam/pages/navbar.dart';
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

  void checkEvenOdd() { // BigInt.tryParse() = angka yang sangat besar, int.tryParse() = angka <20
  BigInt? bigNumber = BigInt.tryParse(numberController.text); 
  
    setState(() {
      if (bigNumber == null) {
        result = "Please enter a valid number.";
      } else {
        if (bigNumber % BigInt.two == BigInt.zero) {
          result = "$bigNumber is Even";
        } else {
          result = "$bigNumber is Odd";
        }
      }
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
              hintText: "Determine a numbers",
              obscureText: false,
            ),
            const SizedBox(height: 20),
            MyButton(onTap: checkEvenOdd, text: "Check",),
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
