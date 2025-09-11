import 'package:flutter/material.dart';

class History extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("History"),),
        body: ListView(
            children: [
                Text("ini Halaman History", style: Theme.of(context).textTheme.headlineLarge,)
            ],
        ),
    );
  }
}
