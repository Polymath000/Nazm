import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/Features/home/data/cubit/task/task_cubit.dart';
import 'package:to_do/Features/home/data/task_model.dart';
import 'package:to_do/Features/home/presentation/views/ViewsInTasksViews/task_row.dart';
import 'package:to_do/constants.dart';

class TaskBody extends StatelessWidget {
  TaskBody({required this.task});
  TaskModel task;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(task),
      background: Container(
        alignment: Alignment.centerRight,
        width: MediaQuery.of(context).size.width / 1.1,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: Colors.red.shade400,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 28,
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        task.delete();
        BlocProvider.of<TaskCubit>(context).fetchAllTasks();
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 1.1,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? Color(0xFF2C2C2E)
              : Colors.white,
          border: Border.all(
              color: isOverdue(task)
                  ? Color(0xFFE57373)
                  : Theme.of(context).brightness == Brightness.dark
                      ? Color(0xFF3E3E41)
                      : Colors.grey.shade300),
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.black.withOpacity(0.2)
                  : Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TaskRow(task: task),
            Padding(
              padding: const EdgeInsets.only(left: 58),
              child: Row(
                children: [
                  Icon(Icons.calendar_today,
                      size: 14,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.grey.shade600),
                  const SizedBox(width: 4),
                  Text(
                    task.firstDate.split(' ')[0],
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(width: 12)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
