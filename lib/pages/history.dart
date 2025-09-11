import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class History extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    
    
    List<String> history = [];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF090909),
        centerTitle: true,
        title: Text(
          "History",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 20),
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [Text("ini Halaman History")],
          ),
        ],
      ),
    );
  }
}
