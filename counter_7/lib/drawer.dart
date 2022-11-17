import 'package:flutter/material.dart';
import 'package:counter_7/main.dart';
import 'package:counter_7/form.dart';
import 'package:counter_7/budget.dart';

enum ScreenName { Home, Form, ShowForm }

class DrawerClass extends StatefulWidget {
  final ScreenName parentScreen;
  const DrawerClass({super.key, required this.parentScreen});
  @override
  State<DrawerClass> createState() => _DrawerClassState();
}

class _DrawerClassState extends State<DrawerClass> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          ListTile(
            title: Text('Counter_7'),
            onTap: () {
              if (widget.parentScreen != ScreenName.Home) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const MyHomePage(title: 'Program Counter',)),
                );
              } else {
                Navigator.pop(context);
              }
            },
          ),
          ListTile(
            title: Text('Tambah Budget'),
            onTap: () {
              if (widget.parentScreen != ScreenName.Form) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const FormPage()),
                );
              } else {
                Navigator.pop(context);
              }
            },
          ),
          ListTile(
            title: Text('Data Budget'),
            onTap: () {
              if (widget.parentScreen != ScreenName.ShowForm) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const MyShowForm()),
                );
              } else {
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }
}