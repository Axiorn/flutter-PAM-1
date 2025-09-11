import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _History();
}

class _History extends State<History> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "History",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
      body: ListView.separated(
  itemCount: history.length,
  separatorBuilder: (context, index) => Divider(
    color: Colors.grey,
    thickness: 1,
  ),
  itemBuilder: (context, index) {
    return ListTile(
      title: Align(
        alignment: Alignment.centerRight,
        child: Text(
          history[index],
          textAlign: TextAlign.right,
          style: Theme.of(context).textTheme.bodyLarge,
                ),
            ),
            );
        },
    )
);

  }
}
