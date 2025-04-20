import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:to_do/Features/home/data/cubit/task/task_cubit.dart';
import 'package:to_do/Features/home/data/task_model.dart';
import 'package:to_do/Features/home/presentation/views/ViewsInTasksViews/task_row.dart';
import 'package:to_do/Features/home/presentation/views/widgets/edit_task.dart';
import 'package:to_do/constants.dart';

class TaskBody extends StatefulWidget {
  TaskBody({super.key, required this.task});
  TaskModel task;

  @override
  State<TaskBody> createState() => _TaskBodyState();
}

class _TaskBodyState extends State<TaskBody> {
  bool _isDismissed = false;

  @override
  Widget build(BuildContext context) {
    if (_isDismissed) {
      return const SizedBox.shrink();
    }

    return Dismissible(
      key: ValueKey(widget.task),
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
      onDismissed: (direction) async {
        setState(() {
          _isDismissed = true;
        });
        final bool isConnected =
            await InternetConnectionChecker.instance.hasConnection;

        if (isConnected && emailOfUser.isNotEmpty) {
          CollectionReference collection =
              FirebaseFirestore.instance.collection(emailOfUser);
          await collection
              .doc(widget.task.title + widget.task.firstDate)
              .delete();
        }
        widget.task.delete();
        if (mounted) {
          BlocProvider.of<TaskCubit>(context).fetchAllTasks();
        }
      },
      child: BlocProvider(
        create: (context) => TaskCubit(),
        child: GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              useSafeArea: true,
              showDragHandle: true,
              enableDrag: true,
              sheetAnimationStyle: AnimationStyle(
                curve: Curves.easeInBack,
                duration: Duration(milliseconds: 500),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              builder: (context) => EditTask(task: widget.task),
            );
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
                  color: isOverdue(widget.task) && !widget.task.isDone
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
                TaskRow(task: widget.task),
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
                        widget.task.firstDate.split(' ')[0],
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
        ),
      ),
    );
  }
}
