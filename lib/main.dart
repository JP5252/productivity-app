import 'package:flutter/material.dart';
import 'package:productivity_app/drawer.dart';
import 'page_titles.dart';
import 'task_page.dart'; // Import the Task Page

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Tasks',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 4, 71, 130)),
        useMaterial3: true,
      ),
      home: const MyTaskPage(),
    );
  }
}
