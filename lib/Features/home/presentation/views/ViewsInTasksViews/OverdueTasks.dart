import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/Features/home/data/cubit/task/task_cubit.dart';
import 'package:to_do/Features/home/data/task_model.dart';
import 'package:to_do/Features/home/presentation/views/widgets/task_body.dart';
import 'package:to_do/constants.dart';

class OverdueTasksView extends StatelessWidget {
  const OverdueTasksView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCubit, TaskState>(
      builder: (context, state) {
        final overdueTasks = context
            .read<TaskCubit>()
            .fetchAllTasks()
            .where((task) => isOverdue(task) && !task.isDone)
            .toList();

        return RefreshIndicator(
          displacement: 100,
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Colors.black,
          onRefresh: () async {
            context.read<TaskCubit>().fetchAllTasks();
          },
          child: Padding(
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
                      return TaskBody(task: overdueTasks[index]);
                    },
                  ),
          ),
        );
      },
    );
  }
}
