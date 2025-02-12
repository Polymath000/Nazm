import 'package:flutter/material.dart';
import 'package:to_do/Features/home/presentation/views/ViewsInTasksViews/AllTasks.dart';
import 'package:to_do/Features/home/presentation/views/ViewsInTasksViews/completedTasks.dart';
import 'package:to_do/Features/home/presentation/views/widgets/show_model_button_sheet.dart';

import '../../../../constants.dart';
import 'settings.dart';
import 'ViewsInTasksViews/ArchieveTasks.dart';
import 'ViewsInTasksViews/Next7DaysTasks.dart';
import 'ViewsInTasksViews/OverdueTasks.dart';
import 'ViewsInTasksViews/TodayTasks.dart';
import 'ViewsInTasksViews/TomorrowTasks.dart';
import 'ViewsInTasksViews/TrashTasks.dart';

class TasksView extends StatefulWidget {
  const TasksView({super.key});

  @override
  State<TasksView> createState() => _TasksViewState();
}

class _TasksViewState extends State<TasksView> {
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(taskViews[_selectedIndex]['title']),
      ),
      floatingActionButton: FloatingActionButton(
          tooltip: 'add Task',
          enableFeedback: true,
          child: const Icon(Icons.add_task_sharp),
          onPressed: () {
            showModalBottomSheet(
                barrierLabel: 'Task',
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                context: context,
                builder: (context) {
                  return const ShowModelButtonSheet();
                });
          }),
      body: taskViews[_selectedIndex]['View'],
      drawer: Drawer(
        width: MediaQuery.of(context).size.width / 1.1,
        child: Container(
          padding: EdgeInsets.only(right: 10),
          child: Column(
            children: [
              DrawerHeader(
                child: Row(
                  children: [
                    CircleAvatar(
                      maxRadius: 30,
                      backgroundImage: AssetImage(testImage),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        testFullName,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Settings(),
                            ));
                      },
                      icon: const Icon(
                        Icons.settings,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(), // Add this
                    // shrinkWrap: true,
                    itemCount: taskViews.length,
                    itemBuilder: (context, index) {
                      return listTile(
                        title: taskViews[index]['title'],
                        icon: taskViews[index]['icon'],
                        index: index,
                        numOftasks: taskViews[index]['numOftasks'],
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  ListTile listTile(
      {required String title,
      required IconData icon,
      required int index,
      required int numOftasks}) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.orange,
      ),
      title: Text(title),
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
        _scaffoldKey.currentState!.closeDrawer();
      },
      //? Number of tasks
      trailing: Text(numOftasks.toString()),
    );
  }
}

List<Map> taskViews = [
  {
    "title": "All Tasks",
    "icon": Icons.all_inbox_rounded,
    "numOftasks": 10,
    "View": AllTasksView()
  },
  {
    "title": "Completed",
    "icon": Icons.check_circle,
    "numOftasks": 5,
    "View": CompletedTasksView()
  },
  {
    "title": "Overdue",
    "icon": Icons.watch_later,
    "numOftasks": 2,
    "View": OverdueTasksView()
  },
  {
    "title": "Today",
    "icon": Icons.today,
    "numOftasks": 1,
    "View": TodayTasksView()
  },
  {
    "title": "Tomorrow",
    "icon": Icons.calendar_today,
    "numOftasks": 1,
    "View": TomorrowTasksView()
  },
  {
    "title": "Next 7 Days",
    "icon": Icons.calendar_view_week,
    "numOftasks": 1,
    "View": Next7DaysTasksView()
  },
  {
    "title": "Trash",
    "icon": Icons.delete,
    "numOftasks": 0,
    "View": TrashTasksView()
  },
  {
    "title": "Archive",
    "icon": Icons.archive,
    "numOftasks": 0,
    "View": ArchieveTasksView()
  },
];
