import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/Features/home/data/cubit/task/task_cubit.dart';
import 'package:to_do/Features/home/presentation/views/widgets/task_body.dart';

class CompletedTasksView extends StatelessWidget {
  const CompletedTasksView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCubit, TaskState>(
      builder: (context, state) {
        final completedTasks = context
            .read<TaskCubit>()
            .fetchAllTasks()
            .where((task) => task.isDone)
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
          ),
        );
      },
    );
  }
}
