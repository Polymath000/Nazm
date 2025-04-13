import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/Features/home/data/cubit/task/task_cubit.dart';
import 'package:to_do/Features/home/presentation/views/widgets/task_body.dart';

class TomorrowTasksView extends StatelessWidget {
  const TomorrowTasksView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          final now = DateTime.now();
          final tomorrow = DateTime(now.year, now.month, now.day);
          
          final tomorrowTasks = BlocProvider.of<TaskCubit>(context)
              .fetchAllTasks()
              .where((task) {
                final taskDate = DateTime.parse(task.firstDate);
                return DateTime(taskDate.year, taskDate.month, taskDate.day)
                    .difference(tomorrow)
                    .inDays == 1;
              })
              .toList()
            ..sort((a, b) => a.isDone == b.isDone ? 0 : a.isDone ? 1 : -1);

          return RefreshIndicator(
            displacement: 100,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
            onRefresh: () async {
              BlocProvider.of<TaskCubit>(context).fetchAllTasks();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: tomorrowTasks.isEmpty
                  ? const Center(child: Text('No tasks yet!'))
                  : ListView.builder(
                      itemCount: tomorrowTasks.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            TaskBody(task: tomorrowTasks[index]),
                            if (index == tomorrowTasks.length - 1)
                              const SizedBox(height: 60),
                          ],
                        );
                      },
                    ),
            ),
          );
        },
      ),
    );
  }
}
