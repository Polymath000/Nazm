import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/Features/home/data/cubit/task/task_cubit.dart';
import 'package:to_do/Features/home/data/task_model.dart';
import 'package:to_do/Features/home/presentation/views/widgets/priority.dart';
import 'show_model_button_sheet.dart';

class TaskBody extends StatefulWidget {
  TaskBody({super.key, required this.task});
  TaskModel task;
  @override
  State<TaskBody> createState() => _TaskBodyState();
}

class _TaskBodyState extends State<TaskBody> {
  void updatePriority(String newPriority) {
    setState(() {
      priority = newPriority;
      widget.task.priority = priority;
      widget.task.save(); // Save the task when priority changes
      BlocProvider.of<TaskCubit>(context)
          .fetchAllTasks(); // Refresh the task list
    });
  }

  late String priority;
  late bool isCompleted;

  @override
  initState() {
    super.initState();
    priority = widget.task.priority;
    isCompleted = widget.task.isDone;
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(widget.task),
      background: Container(
        alignment: Alignment.centerRight,
        width: MediaQuery.of(context).size.width / 1.1,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        widget.task.delete();
        BlocProvider.of<TaskCubit>(context).fetchAllTasks();
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 1.1,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        child: ListTile(
          leading: IconButton(
              onPressed: () {
                setState(() {
                  isCompleted = !isCompleted;
                  widget.task.isDone = isCompleted;
                  widget.task.save();
                  BlocProvider.of<TaskCubit>(context).fetchAllTasks();
                });
              },
              icon: Icon(
                isCompleted ? Icons.check_circle_sharp : Icons.circle_outlined,
                color: isCompleted ? Colors.green : Colors.red,
              )),
          title: Row(
            children: [
              Expanded(
                child: Text(
                  widget.task.title,
                  style: TextStyle(
                    fontSize: 20,
                    decoration: isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Priority(onPrioritySelected: updatePriority),
            ],
          ),
        ),
      ),
    );
  }
}
