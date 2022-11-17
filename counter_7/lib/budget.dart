import 'package:flutter/material.dart';
import 'package:counter_7/main.dart';
import 'package:counter_7/form.dart' as form;
import 'package:counter_7/drawer.dart';

class MyShowForm extends StatefulWidget {
  const MyShowForm({super.key});
  @override
  State<MyShowForm> createState() => _MyShowFormState();
}

class _MyShowFormState extends State<MyShowForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Budget'),
      ),
      drawer: DrawerClass(parentScreen: ScreenName.ShowForm),
      body: ListView.builder(
        itemCount: form.data.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(form.data[index]['title']),
              subtitle: Text(form.data[index]['nominal']),
              trailing: Text(form.data[index]['category'] + " " + form.data[index]['date']),
            ),
          );
        },
      ),
    );
  }
}