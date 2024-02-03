import 'package:flutter/material.dart';
import 'package:productivity_app/calendar_page.dart';
import 'package:productivity_app/main.dart';
import 'page_titles.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
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
                MaterialPageRoute(builder: (context) => const MyApp()),
              );
            },
          ),
          ListTile(
            title: const Text(PageTitles.calendar),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CalendarPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
