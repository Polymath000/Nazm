import 'package:flutter/material.dart';
import 'package:to_do/Features/home/data/task_model.dart';

class EditTask extends StatefulWidget {
  EditTask({super.key, required this.task});
  final TaskModel task;
  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Task"),
      ),
      body: Column(
        children: [
          TextField(
            style: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black),
            controller: TextEditingController(text: widget.task.title),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
              ),
              hintText: "Enter Task Title",
            ),
          ),
        ],
      ),
    );
  }
}
