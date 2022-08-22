import 'package:flutter/material.dart';
import 'package:vocabualize/config/themes/themeConfig.dart';
import 'package:vocabualize/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vocabualize',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const ThemeHandler(home: Home()),
    );
  }
}
