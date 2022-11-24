import 'package:flutter/material.dart';
import 'package:counter_7/page/budget.dart';
import 'package:counter_7/drawer.dart';

class MyFormPage extends StatefulWidget {
    const MyFormPage({super.key});

    @override
    State<MyFormPage> createState() => _MyFormPageState();
}

class _MyFormPageState extends State<MyFormPage> {
    final _formKey = GlobalKey<FormState>();

    String _judul = "";
    int _nominal = 0;
    String _tipe = 'Pemasukan';
    List<String> listTipe = ['Pemasukan', 'Pengeluaran'];
   
    bool isNumeric(String value){
        return int.tryParse(value) != null;
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text('Form'),
            ),
            
            // Menambahkan drawer menu
            drawer: getDrawer(context),
            
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
                                    child:
                                    TextFormField(
                                        decoration: InputDecoration(
                                            hintText: "Judul budget",
                                            labelText: "Judul",
                                            // Menambahkan icon agar lebih intuitif
                                            icon: const Icon(Icons.people),
                                            // Menambahkan circular border agar lebih rapi
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(5.0),
                                            ),
                                        ),
                                        // Menambahkan behavior saat nama diketik 
                                        onChanged: (String? value) {
                                            setState(() {
                                                _judul = value!;
                                            });
                                        },
                                        // Menambahkan behavior saat data disimpan
                                        onSaved: (String? value) {
                                            setState(() {
                                                _judul = value!;
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
                                    child: 
                                    TextFormField(
                                        decoration: InputDecoration(
                                            hintText: "Nominal",
                                            labelText: "Nominal",
                                            // Menambahkan icon agar lebih intuitif
                                            icon: const Icon(Icons.attach_money),
                                            // Menambahkan circular border agar lebih rapi
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(5.0),
                                            ),
                                        ),                                         
                                        
                                        keyboardType: TextInputType.number,

                                        // Menambahkan behavior saat nama diketik 
                                        onChanged: (String? value) {
                                            if (isNumeric(value!)) {
                                            setState(() {
                                                _nominal = int.parse(value);
                                            });
                                            }
                                        },
                                        // Menambahkan behavior saat data disimpan
                                        onSaved: (String? value) {
                                            setState(() {
                                                _nominal = value! as int;
                                            });
                                        },
                                        // Validator sebagai validasi form
                                        validator: (String? value) {
                                            if (value == null || value.isEmpty) {
                                                return 'Nominal tidak boleh kosong!';
                                            } if (!isNumeric(value)) {
                                                return 'Nominal harus berupa angka!';
                                            }
                                            return null;
                                        },
                                    ),  
                                ),
                                Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(20.0),
                                    child: DropdownButton(
                                        hint: const Text('Pilih jenis'),
                                        // value: _tipe,
                                        icon: const Icon(Icons.keyboard_arrow_down),
                                        items: listTipe.map((String items) {
                                            return DropdownMenuItem(
                                            value: items,
                                            child: Text(items),
                                            );
                                        }).toList(),
                                        onChanged: (String? newValue) {
                                            setState(() {
                                            _tipe = newValue!;
                                            });
                                        },
                                    
                                    ),
                                ),
                            ], 
                        ),

                    ),

                ),

            ),
            floatingActionButton: Container( 
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.only(left: 30),
                child: TextButton(
                child: const Text(
                    "Simpan",
                    style: TextStyle(color: Colors.white),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                ),
                onPressed: () {
                    if (_formKey.currentState!.validate()) {
                        inputDataBudget(_judul, _nominal, _tipe);
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const MyFormPage()),
                        );
                    }
                },
            ),
            ),
        );
    }
}