import 'package:flutter/material.dart';
import 'package:to_do/Features/home/presentation/views/ViewsInTasksViews/AllTasks.dart';
import 'package:to_do/Features/home/presentation/views/ViewsInTasksViews/ArchieveTasks.dart';
import 'package:to_do/Features/home/presentation/views/ViewsInTasksViews/Next7DaysTasks.dart';
import 'package:to_do/Features/home/presentation/views/ViewsInTasksViews/OverdueTasks.dart';
import 'package:to_do/Features/home/presentation/views/ViewsInTasksViews/TodayTasks.dart';
import 'package:to_do/Features/home/presentation/views/ViewsInTasksViews/TomorrowTasks.dart';
import 'package:to_do/Features/home/presentation/views/ViewsInTasksViews/TrashTasks.dart';
import 'package:to_do/Features/home/presentation/views/ViewsInTasksViews/completedTasks.dart';

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
