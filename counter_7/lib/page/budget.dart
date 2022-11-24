import 'package:flutter/material.dart';
import 'package:counter_7/page/form.dart';
import 'package:counter_7/main.dart';
import 'package:counter_7/drawer.dart';


class BudgetPage extends StatefulWidget {
    const BudgetPage({super.key});

    @override
    State<BudgetPage> createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {

    // Daftar-daftar data yang disimpan
    static List<String> listJudul = [];
    static List<int> listNominal = [];
    static List<String> listTipe = [];

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text('Display Budget'),
            ),

            // drawer
            drawer: getDrawer(context),

            body:ListView.builder(
                // itemCount: listJudul.length,
                itemBuilder: (context, index) {
                    return Card(
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                                children:[

                                    Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                            listJudul[index], style: const TextStyle(fontSize: 25),
                                            textAlign: TextAlign.left),
                                        ),
                                    ),

                                    Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                            Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Align(
                                                    alignment: Alignment.topLeft,
                                                    child: Text(listNominal[index].toString(), style: TextStyle(fontSize: 15),
                                                        textAlign: TextAlign.left),
                                                ),
                                            ),
                                            Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Align(
                                                    alignment: Alignment.topRight,
                                                    child: Text(listTipe[index], style: TextStyle(fontSize: 15),
                                                        textAlign: TextAlign.right),
                                                ),
                                            ),
                                        ]
                                    ),
                                ],
                            )
                        ),
                    );
                },
                itemCount: listJudul.length,
            ),
        );
    }
}

// memasukkan setiap data ke dalam array untuk ditampilkan
void inputDataBudget(String judul, int nominal, String tipe){ 
    _BudgetPageState.listJudul.add(judul);
    _BudgetPageState.listNominal.add(nominal);
    _BudgetPageState.listTipe.add(tipe);
}