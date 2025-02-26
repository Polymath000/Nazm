import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/Features/home/data/cubit/task/task_cubit.dart';
import 'package:to_do/Features/home/presentation/views/widgets/task_body.dart';

class AllTasksView extends StatelessWidget {
  const AllTasksView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          final tasks = BlocProvider.of<TaskCubit>(context)
              .fetchAllTasks()
              .where((task) => !task.isDone)
              .toList()
            ..sort((a, b) {
              const priorities = {'High': 0, 'Medium': 1, 'Low': 2, '': 3};

              final priorityA = priorities[a.priority] ?? 3;
              final priorityB = priorities[b.priority] ?? 3;
              return priorityA.compareTo(priorityB);
            })
            ..sort((a, b) =>
                b.firstDate.split(' ')[0].compareTo(a.firstDate.split(' ')[0]));

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: tasks.isEmpty
                ? const Center(child: Text('No tasks yet!'))
                : ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          TaskBody(task: tasks[index]),
                          if (index == tasks.length - 1)
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
