import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/Features/home/data/cubit/task/task_cubit.dart';
import 'package:to_do/Features/home/data/task_model.dart';
import 'package:to_do/Features/home/presentation/views/widgets/task_body.dart';

class AllTasksView extends StatelessWidget {
  const AllTasksView({super.key});

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
            for (int i = 0; i < tasks.length; i++) {
              tasks[i].isDone ? tasks.remove(tasks[i]) : null;
            }
            // tasks.sort((a, b) => a.isDone == b.isDone
            //     ? 0
            //     : a.isDone
            //         ? 1
            //         : -1);
            // tasks.reversed;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: tasks.isEmpty
                  ? const Center(child: Text('No tasks yet!'))
                  : ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        if (index == tasks.length - 1) {
                          return Column(
                            children: [
                              TaskBody(task: tasks[index]),
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
