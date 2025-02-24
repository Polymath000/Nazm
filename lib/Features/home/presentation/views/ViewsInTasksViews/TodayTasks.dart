import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/Features/home/data/cubit/task/task_cubit.dart';
import 'package:to_do/Features/home/data/task_model.dart';
import 'package:to_do/Features/home/presentation/views/widgets/task_body.dart';

class TodayTasksView extends StatelessWidget {
  const TodayTasksView({super.key});
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
            List<TaskModel> todayTasks = [];

            for (int i = 0; i < tasks.length; i++) {
              tasks[i].firstDate.split(' ')[0] ==
                      DateTime.now().toString().split(' ')[0]
                  ? todayTasks.add(tasks[i])
                  : null;
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: todayTasks.isEmpty
                  ? const Center(child: Text('No tasks yet!'))
                  : ListView.builder(
                      itemCount: todayTasks.length,
                      itemBuilder: (context, index) {
                        if (index == todayTasks.length - 1) {
                          return Column(
                            children: [
                              TaskBody(task: todayTasks[index]),
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
