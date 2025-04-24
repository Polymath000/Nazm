import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:to_do/Features/home/data/cubit/add_task/add_task_cubit.dart';
import 'package:to_do/Features/home/data/cubit/task/task_cubit.dart';
import 'package:to_do/Features/home/data/task_model.dart';
import 'package:to_do/Features/home/presentation/views/widgets/add%20task/sample_date_picker.dart';
import 'package:to_do/Features/home/presentation/views/widgets/priority.dart';
import 'package:to_do/constants.dart';

class AddTaskForm extends StatefulWidget {
  AddTaskForm(
      {super.key, required this.date, required this.updateSavingvariable});
  DateTime date;
  final Function(bool) updateSavingvariable;
  @override
  State<AddTaskForm> createState() => _AddTaskFormState();
}

class _AddTaskFormState extends State<AddTaskForm> {
  void updatePriority(String newPriority) {
    setState(() {
      priority = newPriority;
    });
  }

  late String title;
  late String description = "";
  late String priority = kPrimaryPriority;
  bool descriptionIsVisible = false;
  final GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autoValidate = AutovalidateMode.disabled;

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

  bool isSaving = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: autoValidate,
      key: formKey,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                minLines: 1,
                maxLines: 3,
                autofocus: true,
                onSaved: (value) {
                  title = value!;
                },
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Field is required';
                  } else {
                    title = value!;
                    return null;
                  }
                },
                decoration: InputDecoration(
                  hintText: 'What would you like to do?',
                  hintStyle: TextStyle(color: Colors.grey),
                  focusedBorder:
                      OutlineInputBorder(borderSide: BorderSide.none),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              Visibility(
                visible: descriptionIsVisible,
                child: TextFormField(
                  minLines: 1,
                  maxLines: 3,
                  onSaved: (value) {
                    description = value!;
                  },
                  decoration: InputDecoration(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        descriptionIsVisible = !descriptionIsVisible;
                      });
                    },
                    icon: const Icon(Icons.description),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.calendar_month_outlined),
                              onPressed: () async {
                                await ShowDialog(
                                  context: context,
                                  startDateSelected: widget.date,
                                  onDateSelected: (String newDate) {
                                    print("New date selected: $newDate");
                                    setState(() {
                                      widget.date = DateTime.parse(newDate);
                                    });
                                  },
                                );
                              },
                            ),
                            Text(
                              "${widget.date.day}-${widget.date.month}-${widget.date.year}",
                              style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Priority(
                    onPrioritySelected: updatePriority,
                    color: getPriorityColor(),
                  ),
                  IconButton(
                    onPressed: () async {
                      setState(() {
                        isSaving = true;
                        widget.updateSavingvariable(isSaving);
                      });
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        var task = TaskModel(
                          firstDate: widget.date.toString(),
                          priority: priority,
                          title: title,
                          description: description,
                          isDone: false,
                        );

                        BlocProvider.of<AddTaskCubit>(context).addTask(task);
                        BlocProvider.of<TaskCubit>(context).fetchAllTasks();
                        setState(() {
                          isSaving = false;
                        });
                        final bool isConnected = await InternetConnectionChecker
                            .instance.hasConnection;
                        if (isConnected && emailOfUser.isNotEmpty) {
                          CollectionReference newTask = FirebaseFirestore
                              .instance
                              .collection(emailOfUser);
                          newTask.doc(title + widget.date.toString()).set({
                            "Title": title,
                            "firstDate": widget.date.toString(),
                            "description": description,
                            "isDone": false,
                            "priority": priority,
                          });
                        }
                      } else {
                        setState(() {
                          autoValidate = AutovalidateMode.always;
                        });
                      }
                    },
                    icon: isSaving
                        ? const CircularProgressIndicator()
                        : const Icon(Icons.arrow_forward_rounded),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
