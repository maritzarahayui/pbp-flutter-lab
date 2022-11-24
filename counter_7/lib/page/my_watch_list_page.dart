import 'package:counter_7/page/detail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:counter_7/model/my_watch_list.dart';
import 'package:counter_7/fetch_my_watchlist.dart';
import 'package:counter_7/drawer.dart';

class MyWatchListPage extends StatefulWidget {
    const MyWatchListPage({Key? key}) : super(key: key);

    @override
    // ignore: library_private_types_in_public_api
    _MyWatchListPageState createState() => _MyWatchListPageState();
}

class _MyWatchListPageState extends State<MyWatchListPage> {
    Future dataWatchlist = fetchMyWatchList();

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: const Text('My Watchlist'),
            ),

            // Menambahkan drawer menup
            drawer: getDrawer(context),

            body: FutureBuilder(
                future: dataWatchlist,
                builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                    return const Center(child: CircularProgressIndicator());
                    } else {
                    if (!snapshot.hasData) {
                        return Column(
                        children: const [
                            Text(
                            "Tidak ada watchlist :(",
                            style: TextStyle(
                                color: Color(0xff59A5D8),
                                fontSize: 20),
                            ),
                            SizedBox(height: 8),
                        ],
                        );
                    } else {
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (_, index)=> GestureDetector(
                            onTap: () {
                            // Route menu ke halaman form
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => DetailPage(film: snapshot.data![index])),
                            );
                            },
                            child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            padding: const EdgeInsets.all(20.0),
                            decoration: BoxDecoration(
                                color: snapshot.data![index].fields.watched == "Done"? 
                                    Color.fromARGB(240, 110, 333, 180) : Color.fromARGB(249, 204, 133, 255),
                                
                                borderRadius: BorderRadius.circular(15.0),
                                boxShadow: const [
                                BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 2.0
                                )
                                ]
                            ),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [ Text(
                                      "${snapshot.data![index].fields.title}",
                                      style: const TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    Expanded(child: Container()),

                                    Checkbox(  
                                      value: snapshot.data![index].fields.watched == "Done"? true:false,  
                                      onChanged: (value) {  
                                        setState(() {  
                                          snapshot.data![index].fields.watched = value!? "Done":"To Do"; 
                                        });  
                                      },  
                                    ),
                                    ]
                                  ),
                                ],
                            ),
                            )
                          )
                        );
                    }
                    }
                }
            )
        );
    }

}