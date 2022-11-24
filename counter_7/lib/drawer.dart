import 'package:flutter/material.dart';
import 'package:counter_7/main.dart';
import 'package:counter_7/page/budget.dart';
import 'package:counter_7/page/form.dart';
import 'package:counter_7/page/my_watch_list_page.dart';

Drawer getDrawer(BuildContext context) {
    return Drawer(
        child: Column(
            children: [
            // Menambahkan clickable menu
            ListTile(
                title: const Text('counter_7'),
                onTap: () {
                // Route menu ke halaman utama
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const MyHomePage()),
                );
                },
            ),
            ListTile(
                title: const Text('Tambah Budget'),
                onTap: () {
                // Route menu ke halaman form
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const MyFormPage()),
                );
                },
            ),
            ListTile(
                title: const Text('Data Budget'),
                onTap: () {
                // Route menu ke halaman tampilin data
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const BudgetPage()),
                );
                },
            ),
            ListTile(
                title: const Text('My WatchList'),
                onTap: () {
                    // Route menu ke halaman my watchlist
                    Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const MyWatchListPage()),
                    );
                },
            ),
            ],
        ),
    );
}