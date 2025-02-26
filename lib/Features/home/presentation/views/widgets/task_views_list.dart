import 'package:flutter/material.dart';
import 'package:to_do/Features/home/presentation/views/ViewsInTasksViews/AllTasks.dart';
import 'package:to_do/Features/home/presentation/views/ViewsInTasksViews/Next7DaysTasks.dart';
import 'package:to_do/Features/home/presentation/views/ViewsInTasksViews/OverdueTasks.dart';
import 'package:to_do/Features/home/presentation/views/ViewsInTasksViews/TodayTasks.dart';
import 'package:to_do/Features/home/presentation/views/ViewsInTasksViews/TomorrowTasks.dart';
import 'package:to_do/Features/home/presentation/views/ViewsInTasksViews/completedTasks.dart';

List<Map> taskViews = [
  {
    "title": "All Tasks",
    "icon": Icons.all_inbox_rounded,
    "View": AllTasksView()
  },
  {
    "title": "Completed",
    "icon": Icons.check_circle,
    "View": CompletedTasksView()
  },
  {"title": "Overdue", "icon": Icons.watch_later, "View": OverdueTasksView()},
  {"title": "Today", "icon": Icons.today, "View": TodayTasksView()},
  {
    "title": "Tomorrow",
    "icon": Icons.calendar_today,
    "View": TomorrowTasksView()
  },
  {
    "title": "Next 7 Days",
    "icon": Icons.calendar_view_week,
    "View": Next7DaysTasksView()
  },
];
