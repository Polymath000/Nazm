import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/Features/home/data/cubit/task/task_cubit.dart';
import 'package:to_do/Features/home/data/task_model.dart';
import 'package:to_do/Features/home/presentation/views/widgets/task_body.dart';

class OverdueTasksView extends StatelessWidget {
  const OverdueTasksView({super.key});
  void rebuild(BuildContext context) {
    BlocProvider.of<TaskCubit>(context).fetchAllTasks();
  }

  @override
  Widget build(BuildContext context) {
    rebuild(context);
    return BlocProvider(
      create: (context) => TaskCubit(),
      child: Scaffold(
        body: BlocBuilder<TaskCubit, TaskState>(
          builder: (context, state) {
            List<TaskModel> tasks =
                BlocProvider.of<TaskCubit>(context).fetchAllTasks();
            List<TaskModel> overdueTasks = [];

            // for (int i = 0; i < tasks.length; i++) {
            //   DateTime taskDate = DateTime.parse(tasks[i].firstDate);
            //   DateTime today = DateTime.now();
            //   if (taskDate.isBefore(today)) {
            //     print('${taskDate} now : ${today}');

            //     overdueTasks.add(tasks[i]);
            //   }
            // }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: overdueTasks.isEmpty
                  ? const Center(child: Text('No tasks yet!'))
                  : ListView.builder(
                      itemCount: overdueTasks.length,
                      itemBuilder: (context, index) {
                        if (index == overdueTasks.length - 1) {
                          return Column(
                            children: [
                              TaskBody(task: overdueTasks[index]),
                              SizedBox(
                                height: 60,
                              ),
                            ],
                          );
                        }
                        return TaskBody(task: tasks[index]);
                      },
                    ),
            );
          },
        ),
      ),
    );
  }
}
