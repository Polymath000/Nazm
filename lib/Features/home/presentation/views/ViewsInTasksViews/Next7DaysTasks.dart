import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/Features/home/data/cubit/task/task_cubit.dart';
import 'package:to_do/Features/home/data/task_model.dart';
import 'package:to_do/Features/home/presentation/views/widgets/task_body.dart';
import 'package:to_do/Features/home/presentation/views/widgets/task_views_list.dart';

class Next7DaysTasksView extends StatelessWidget {
  const Next7DaysTasksView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          final now = DateTime.now();
          final today = DateTime(now.year, now.month, now.day);
          
          final next7DaysTasks = BlocProvider.of<TaskCubit>(context)
              .fetchAllTasks()
              .where((task) {
                final taskDate = DateTime.parse(task.firstDate);
                final diff = DateTime(taskDate.year, taskDate.month, taskDate.day)
                    .difference(today)
                    .inDays;
                return diff > 0 && diff <= 7;
              })
              .toList()
            ..sort((a, b) => a.isDone == b.isDone ? 0 : a.isDone ? 1 : -1);

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: next7DaysTasks.isEmpty
                ? const Center(child: Text('No tasks yet!'))
                : ListView.builder(
                    itemCount: next7DaysTasks.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          TaskBody(task: next7DaysTasks[index]),
                          if (index == next7DaysTasks.length - 1)
                            const SizedBox(height: 60),
                        ],
                      );
                    },
                  ),
          );
        },
      ),
    );
  }
}
