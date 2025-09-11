import 'package:flutter/material.dart';
import 'package:tugas1_pam/pages/testing_page1.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        title: Text("data"),
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.blue,
          child: ListView(
            children: [
              ListTile(
                leading: Icon(Icons.person, color: Colors.white),
                title: Text(
                  "Data Kelompok",
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Testingpage1()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.calculate, color: Colors.white),
                title: Text(
                  "Kalkulator",
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Testingpage1()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.confirmation_number, color: Colors.white),
                title: Text(
                  "Ganjil Genap",
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => EvenOddPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.format_list_numbered, color: Colors.white),
                title: Text(
                  "Digit",
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => DigitCounterPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.logout_rounded, color: Colors.white),
                title: Text(
                  "Keluar",
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
