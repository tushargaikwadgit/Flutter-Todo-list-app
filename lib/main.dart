// ignore_for_file: unused_import

import 'package:advance_todo/View/loginpage.dart';
import 'package:flutter/material.dart';

dynamic database;

void main() async {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LogInPage(),
    );
  }
}
