import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:counter_7/drawer.dart';
import 'package:counter_7/budget.dart';
import 'package:counter_7/main.dart';
import 'package:intl/intl.dart';

var data = <Map>[];

class FormPage extends StatefulWidget {
  const FormPage({super.key});
  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _nominal = '';
  List<String> _categories = ['Pemasukan', 'Pengeluaran'];
  var _selectedCategory = null;

  TextEditingController dateInput = TextEditingController();

  void clearText() {
    _title = '';
    _nominal = '';
  }

  @override
  void initState() {
    dateInput.text = DateFormat('dd-MM-yyyy').format(DateTime.now());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form'),
      ),
      drawer: DrawerClass(parentScreen: ScreenName.Form),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Padding(
                  // Menggunakan padding sebesar 8 pixels
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.title),
                      hintText: "Beli Buku",
                      labelText: "Judul",
                      // Menambahkan icon agar lebih intuitif
                      // Menambahkan circular border agar lebih rapi
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    // Menambahkan behavior saat nama diketik
                    onChanged: (String? value) {
                      setState(() {
                        _title = value!;
                      });
                    },
                    // Menambahkan behavior saat data disimpan
                    onSaved: (String? value) {
                      setState(() {
                        _title = value!;
                      });
                    },
                    // Validator sebagai validasi form
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Judul tidak boleh kosong!';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  // Menggunakan padding sebesar 8 pixels
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.attach_money),
                      hintText: "5000",
                      labelText: "Nominal",
                      // Menambahkan icon agar lebih intuitif
                      // Menambahkan circular border agar lebih rapi
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],

                    // Menambahkan behavior saat nama diketik
                    onChanged: (String? value) {
                      setState(() {
                        _nominal = value!;
                      });
                    },
                    // Menambahkan behavior saat data disimpan
                    onSaved: (String? value) {
                      setState(() {
                        _nominal = value!;
                      });
                    },
                    // Validator sebagai validasi form
                    validator: (String? value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.startsWith('0')) {
                        return 'Nominal tidak boleh kosong!';
                      }
                      return null;
                    },
                  ),
                ),
                TextFormField(
                  controller: dateInput,
                  decoration: InputDecoration(
                    icon: Icon(Icons.calendar_today),
                    labelText: "Masukkan tanggal",
                  ),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1950),
                      lastDate: DateTime(2100));
                    if (pickedDate != null) {
                      String formattedDate =
                      DateFormat('dd-MM-yyy').format(pickedDate);

                      setState(() {
                        dateInput.text = formattedDate;
                      });
                    } else {}
                  },
                ),
                DropdownButtonHideUnderline(
                  child: DropdownButtonFormField(
                      hint: Text('Pilih jenis'),
                      items: _categories.map((jenis) {
                        return DropdownMenuItem(
                          value: jenis,
                          child: Text(jenis),
                        );
                      }).toList(),
                      value: _selectedCategory,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedCategory = newValue!;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Jenis tidak boleh kosong!';
                        }
                        return null;
                      },
                  ),
                ),
                TextButton(
                  child: const Text(
                    "Simpan",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.all(16)),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      var map = {};
                      map['title'] = _title;
                      map['nominal'] = _nominal;
                      map['category'] = _selectedCategory;
                      map['date'] = dateInput.text;
                      data.add(map);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Data berhasil disimpan!'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                    clearText();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}