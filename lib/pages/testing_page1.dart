import 'package:flutter/material.dart';
import 'package:tugas1_pam/pages/navbar.dart';

class Testingpage1 extends StatelessWidget {
  const Testingpage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Navbar(),
      appBar: AppBar(
        
      ),
      body: Center(
        child: Text("TESTING PAGE 1")
      ),
    );
  }
}