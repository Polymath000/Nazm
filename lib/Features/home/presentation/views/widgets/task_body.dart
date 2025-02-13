import 'package:flutter/material.dart';
import 'package:to_do/Features/home/presentation/views/widgets/priority.dart';
import 'package:to_do/constants.dart';

import 'show_model_button_sheet.dart';

class TaskBody extends StatefulWidget {
  const TaskBody({
    super.key,
  });

  @override
  State<TaskBody> createState() => _TaskBodyState();
}

class _TaskBodyState extends State<TaskBody> {
  void updatePriority(String newPriority) {
    setState(() {
      priority = newPriority;
    });
  }

  String priority = kPrimaryPriority;
  bool isCompleted = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width / 1.1,
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
              });
            },
            icon: Icon(
              isCompleted ? Icons.check_circle_sharp : Icons.circle_outlined,
              color: isCompleted ? Colors.green : Colors.red,
            )),
        title: GestureDetector(
          onTap: () {
            showModalBottomSheet(
                barrierLabel: 'Task',
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                context: context,
                builder: (context) {
                  return const ShowModelButtonSheet();
                });
          },
          child: Text(
            'Task Title',
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
        trailing: Priority(
          onPrioritySelected: updatePriority,
        ),
      ),
    );
  }
}
