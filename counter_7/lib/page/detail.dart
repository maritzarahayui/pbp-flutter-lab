import 'package:counter_7/model/my_watch_list.dart';
import 'package:flutter/material.dart';
import 'package:counter_7/page/form.dart';
import 'package:counter_7/page/my_watch_list_page.dart';
import 'package:counter_7/main.dart';
import 'package:counter_7/drawer.dart';


class DetailPage extends StatefulWidget {
    const DetailPage({super.key, required this.film});
    final MyWatchList film;
    @override
    State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: const Text('Detail Film'),
            ),

            // drawer
            drawer: getDrawer(context),

            body: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                        children:[
                            Padding(
                                padding: const EdgeInsets.only(top:20, bottom:15),
                                child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                    widget.film.fields.title, textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                                ),
                            ),

                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [ 
                                      const Text(
                                        "Release date:", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                                      Container(width: 15),
                                      Text( 
                                        widget.film.fields.releaseDate.toString(), style: const TextStyle(fontSize: 25)),
                                      ],
                                  ),
                            ),

                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [ 
                                      const Text(
                                        "Rating:", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                                      Container(width: 15),
                                      Text( 
                                        "${widget.film.fields.rating.toString()}/5", 
                                        style: const TextStyle(fontSize: 25)),
                                      ],
                                  ),
                            ),

                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [ 
                                      const Text(
                                        "Status:", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                                      Container(width: 15),
                                      Text( 
                                        widget.film.fields.watched, style: const TextStyle(fontSize: 25)),
                                      ],
                                  ),
                            ),

                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [ 
                                      const Text(
                                        "Review:", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                                      Container(width: 15),
                                      Text( 
                                        widget.film.fields.review, style: const TextStyle(fontSize: 25)),
                                      ],
                                  ),
                            ),

                            Expanded(child: Container()),
                    
                            Container( 
                              alignment: Alignment.bottomCenter,
                              padding: const EdgeInsets.all(25),
                              child: TextButton(
                                child: const Text(
                                  "Back", style: TextStyle(color: Colors.white)),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Colors.blue)),
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => const MyWatchListPage()),
                                  );
                                }
                              ),
                            ),

                        ],
                    )
                ),
      );
    }
}