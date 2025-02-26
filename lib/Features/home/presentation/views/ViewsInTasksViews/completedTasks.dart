import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/Features/home/data/cubit/task/task_cubit.dart';
import 'package:to_do/Features/home/data/task_model.dart';
import 'package:to_do/Features/home/presentation/views/widgets/task_body.dart';
import 'package:to_do/Features/home/presentation/views/widgets/task_views_list.dart';

class CompletedTasksView extends StatelessWidget {
  const CompletedTasksView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          final completedTasks = BlocProvider.of<TaskCubit>(context)
              .fetchAllTasks()
              .where((task) => task.isDone)
              .toList();

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: completedTasks.isEmpty
                ? const Center(child: Text('No tasks yet!'))
                : ListView.builder(
                    itemCount: completedTasks.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          TaskBody(task: completedTasks[index]),
                          if (index == completedTasks.length - 1)
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
