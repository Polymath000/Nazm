import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/Features/home/data/cubit/task/task_cubit.dart';
import 'package:to_do/Features/home/presentation/views/widgets/task_body.dart';

class TodayTasksView extends StatelessWidget {
  const TodayTasksView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          final todayTasks = BlocProvider.of<TaskCubit>(context)
              .fetchAllTasks()
              .where((task) => 
                task.firstDate.split(' ')[0] == DateTime.now().toString().split(' ')[0])
              .toList()
            ..sort((a, b) => a.isDone == b.isDone ? 0 : a.isDone ? 1 : -1);

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: todayTasks.isEmpty
                ? const Center(child: Text('No tasks yet!'))
                : ListView.builder(
                    itemCount: todayTasks.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          TaskBody(task: todayTasks[index]),
                          if (index == todayTasks.length - 1)
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
