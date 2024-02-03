import 'package:flutter/material.dart';
import 'package:productivity_app/drawer.dart';
import 'package:productivity_app/page_titles.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime today = DateTime.now();

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          PageTitles.calendar,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      drawer: const MyDrawer(),
      body: TableCalendar(
        headerStyle:
            const HeaderStyle(formatButtonVisible: false, titleCentered: true),
        availableGestures: AvailableGestures.all,
        focusedDay: today,
        onDaySelected: _onDaySelected,
        selectedDayPredicate: (day) => isSameDay(day, today), // to select day
        firstDay: DateTime.utc(2000, 01, 01),
        lastDay: DateTime.utc(2100, 01, 01),
      ),
    );
  }
}
