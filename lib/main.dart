
import 'package:flutter/material.dart';
import 'package:recipe_ai/views/home_view.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomeView(),
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.pink[400],
        primaryColor: Colors.white,
      ),
    );
  }
}