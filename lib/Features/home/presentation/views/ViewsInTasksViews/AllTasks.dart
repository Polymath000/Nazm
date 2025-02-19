import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/Features/home/data/cubit/task/task_cubit.dart';
import 'package:to_do/Features/home/data/task_model.dart';
import 'package:to_do/Features/home/presentation/views/widgets/task_body.dart';

class AllTasksView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskCubit(),
      child: Scaffold(
        body: BlocBuilder<TaskCubit, TaskState>(
          builder: (context, state) {
            List<TaskModel> tasks =
                BlocProvider.of<TaskCubit>(context).fetchAllTasks() ?? [];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: tasks.isEmpty
                  ? const Center(child: Text('No tasks yet!'))
                  : ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
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
