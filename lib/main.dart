import 'package:flutter/material.dart';
import 'package:productivity_app/task_page.dart';
import 'package:productivity_app/task_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:productivity_app/firebase_options.dart';

Future<void> main() async {
  final TaskManager taskManager = TaskManager();
  runApp(MyApp(taskManager: taskManager));

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  final TaskManager taskManager;

  const MyApp({super.key, required this.taskManager});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Tasks',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 4, 71, 130),
        ),
        useMaterial3: true,
      ),
      home: TaskPage(taskManager: taskManager),
    );
  }
}
