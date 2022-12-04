import 'package:flutter/material.dart';
import 'package:flutter_sklad/core/db/data_base_helper.dart';
import 'package:flutter_sklad/screens/Screen.dart';
import 'package:sqflite/sqflite.dart';
Future<void> main() async {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Screen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

