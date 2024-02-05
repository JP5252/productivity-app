import 'package:flutter/material.dart';
import 'package:productivity_app/calendar_page.dart';
import 'package:productivity_app/task_page.dart';
import 'package:productivity_app/page_titles.dart';
import 'package:productivity_app/task_manager.dart';

class MyDrawer extends StatefulWidget {
  final TaskManager taskManager;

  const MyDrawer({Key? key, required this.taskManager}) : super(key: key);

  @override
  _DrawerState createState() => _DrawerState();
}

class _DrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            child: null,
          ),
          ListTile(
            title: const Text(PageTitles.todaysTasks),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      TaskPage(taskManager: widget.taskManager),
                ),
              );
            },
          ),
          ListTile(
            title: const Text(PageTitles.calendar),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      CalendarPage(taskManager: widget.taskManager),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
