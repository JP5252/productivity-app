import 'package:flutter/material.dart';
import 'package:productivity_app/drawer.dart';
import 'package:productivity_app/page_titles.dart';
import 'package:productivity_app/task_manager.dart';
import 'package:productivity_app/task.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime today = DateTime.now();
  DateTime? _selectedDay;

  late final ValueNotifier<List<Task>> _selectedTasks;

  // set initial state of selected day to today
  @override
  void initState() {
    super.initState();
    _selectedDay = today; // Set the default selected day to today
    _selectedTasks = ValueNotifier(_getTasksForDay(_selectedDay!));
  }

  TaskManager taskManager = TaskManager();
  TextEditingController _addTaskNameController = TextEditingController();

  // for selecting a day in the calendar
  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
      _selectedDay = day;
      _selectedTasks.value = _getTasksForDay(day);
    });
  }

  // get all the events from selected day
  List<Task> _getTasksForDay(DateTime day) {
    return taskManager.tasks[day] ?? [];
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
      body: Column(
        children: [
          TableCalendar(
            // setup
            focusedDay: today,
            firstDay: DateTime.utc(2000, 01, 01),
            lastDay: DateTime.utc(2100, 01, 01),
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
            ),
            availableGestures: AvailableGestures.all,
            // for selection of day
            onDaySelected: _onDaySelected,
            selectedDayPredicate: (day) => isSameDay(day, today),
            // get the tasks for selected day
            eventLoader: _getTasksForDay,
          ),
          Expanded(
            child: ValueListenableBuilder<List<Task>>(
                valueListenable: _selectedTasks,
                builder: (context, value, _) {
                  return ListView.builder(
                      itemCount: value.length,
                      itemBuilder: (context, index) {
                        return Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(12)),
                            child: ListTile(title: Text(value[index].title)));
                      });
                }),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                scrollable: true,
                title: const Text('Add a task'),
                content: Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextField(
                    controller: _addTaskNameController,
                  ),
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Task newTask = Task(_addTaskNameController.text);
                      taskManager.addTask(_selectedDay!, newTask);
                      Navigator.of(context).pop();
                      _selectedTasks.value = _getTasksForDay(_selectedDay!);
                    },
                    child: Text('Submit'),
                  ),
                ],
              );
            },
          );
        },
        tooltip: 'Add a Task',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
