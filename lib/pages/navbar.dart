import 'package:flutter/material.dart';
import 'package:tugas1_pam/pages/calculator.dart';
import 'package:tugas1_pam/pages/group_members.dart';
import 'count_page.dart';
import 'oddeven_page.dart';
import 'login.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
          color: const Color.fromARGB(255, 80, 82, 83),
          padding: EdgeInsets.only(top: 25, left: 15),
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
                    MaterialPageRoute(builder: (context) => GroupMembersPage()),
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
                    MaterialPageRoute(builder: (context) => CalculatorApp()),
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
                  Navigator.of(
                    context,
                  ).push(MaterialPageRoute(builder: (context) => Login()));
                },
              ),
            ],
          ),
        ),
    );
  }
}
