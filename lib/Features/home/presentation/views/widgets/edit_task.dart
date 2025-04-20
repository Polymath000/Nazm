import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:to_do/Features/home/data/cubit/task/task_cubit.dart';
import 'package:to_do/Features/home/data/task_model.dart';
import 'package:to_do/Features/home/presentation/views/widgets/add%20task/sample_date_picker.dart';
import 'package:to_do/Features/home/presentation/views/widgets/priority.dart';
import 'package:to_do/constants.dart';

class EditTask extends StatefulWidget {
  const EditTask({super.key, required this.task});
  final TaskModel task;
  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  late bool isCompleted;
  late String firstDate;
  late String description;
  late bool descriptionIsVisible;
  late String priority;
  late String title;
  final GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autoValidate = AutovalidateMode.disabled;

  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;

  bool _isSaving = false;
  late String oldTitle;
  late String oldFirstDate;
  @override
  void initState() {
    super.initState();
    firstDate = widget.task.firstDate;
    description = widget.task.description;
    priority = widget.task.priority;
    isCompleted = widget.task.isDone;
    title = widget.task.title;
    descriptionIsVisible = widget.task.description.isNotEmpty;
    oldTitle = widget.task.title;
    oldFirstDate = widget.task.firstDate.toString();
    _titleController = TextEditingController(text: title);
    _descriptionController = TextEditingController(text: description);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _saveTask() async {
    if (_isSaving) return;
    setState(() {
      _isSaving = true;
    });

    try {
      if (!formKey.currentState!.validate()) {
        setState(() {
          autoValidate = AutovalidateMode.always;
        });
        return;
      }
      print("old Title = ${oldTitle} , old Date = ${oldFirstDate}");
      formKey.currentState!.save();
      widget.task.isDone = isCompleted;
      widget.task.firstDate = firstDate;
      widget.task.priority = priority;
      widget.task.title = title;
      widget.task.description = description;
      await widget.task.save();

      final bool isConnected =
          await InternetConnectionChecker.instance.hasConnection;

      if (isConnected && emailOfUser.isNotEmpty) {
        CollectionReference collection =
            FirebaseFirestore.instance.collection(emailOfUser);
        await collection.doc(oldTitle + oldFirstDate).delete();
        collection.doc(title + firstDate.toString()).set({
          "Title": oldTitle,
          "firstDate": firstDate.toString(),
          "description": description,
          "isDone": isCompleted,
          "priority": priority,
        });
      }

      Navigator.pop(context);

      context.read<TaskCubit>().fetchAllTasks();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Task updated successfully')),
      );
    } catch (e) {
      if (!mounted) return;
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  void _handleTaskCompletion() async {
    setState(() {
      isCompleted = !isCompleted;
    });
    _saveTask();
    Future.delayed(Duration(seconds: 1), () {
      if (isCompleted) {
        Navigator.pop(context);
      }
    });
  }

  void updatePriority(String newPriority) {
    setState(() {
      priority = newPriority;
    });
  }

  void updateDate(String fdate) {
    setState(() {
      firstDate = fdate;
    });
  }

  void toggleDescription() {
    setState(() {
      descriptionIsVisible = !descriptionIsVisible;
    });
  }

  Color getPriorityColor() {
    if (priority.contains('High')) {
      return Colors.red;
    } else if (priority.contains('Medium')) {
      return Colors.yellow;
    } else if (priority.contains('Low')) {
      return Colors.blue;
    } else {
      return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: autoValidate,
      key: formKey,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.55,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(children: [
              IconButton(
                onPressed: _handleTaskCompletion,
                icon: Icon(
                  isCompleted ? Icons.check_circle : Icons.circle_outlined,
                  color: isCompleted
                      ? Theme.of(context).brightness == Brightness.dark
                          ? const Color(0xFF4CAF50)
                          : const Color(0xFF2E7D32)
                      : Theme.of(context).brightness == Brightness.dark
                          ? Colors.grey.shade500
                          : Colors.grey.shade400,
                  size: 28,
                ),
              ),
              Expanded(
                child: TextFormField(
                  controller: _titleController,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Title is required';
                    }
                    return null;
                  },
                  minLines: 1,
                  maxLines: 3,
                  autofocus: true,
                  onSaved: (value) {
                    title = value!;
                  },
                  style: TextStyle(
                    fontSize: 22,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                    decoration: isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
            ]),
            Visibility(
              visible: descriptionIsVisible,
              child: TextFormField(
                controller: _descriptionController,
                minLines: 1,
                maxLines: 3,
                onSaved: (value) {
                  description = value ?? '';
                },
                decoration: const InputDecoration(
                  hintText: 'Description',
                  hintStyle: TextStyle(color: Colors.grey),
                  focusedBorder:
                      OutlineInputBorder(borderSide: BorderSide.none),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                ShowDialog(
                    context: context,
                    onDateSelected: updateDate,
                    startDateSelected: DateTime.parse(firstDate));
              },
              child: Row(
                children: [
                  SizedBox(width: 10),
                  Icon(Icons.calendar_today, size: 23, color: Colors.red),
                  const SizedBox(width: 4),
                  Text(
                    formatDate(
                            DateTime.parse(firstDate), [d, '-', MM, '-', yyyy])
                        .toString(),
                    style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Priority(
                  onPrioritySelected: updatePriority,
                  color: getPriorityColor(),
                ),
                const SizedBox(width: 20),
                SizedBox(width: 120),
                IconButton(
                  onPressed: _isSaving ? null : _saveTask,
                  icon: _isSaving
                      ? const CircularProgressIndicator()
                      : const Icon(Icons.arrow_forward_rounded),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
