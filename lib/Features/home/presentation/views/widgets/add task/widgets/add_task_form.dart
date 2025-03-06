import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/Features/home/data/cubit/add_task/add_task_cubit.dart';
import 'package:to_do/Features/home/data/cubit/task/task_cubit.dart';
import 'package:to_do/Features/home/data/task_model.dart';
import 'package:to_do/Features/home/presentation/views/widgets/add%20task/sample_date_picker.dart';
import 'package:to_do/Features/home/presentation/views/widgets/category_drop_down.dart';
import 'package:to_do/Features/home/presentation/views/widgets/priority.dart';
import 'package:to_do/constants.dart';

class AddTaskForm extends StatefulWidget {
  const AddTaskForm({super.key});

  @override
  State<AddTaskForm> createState() => _AddTaskFormState();
}

class _AddTaskFormState extends State<AddTaskForm> {
  void updateCategory(String newCategory) {
    setState(() {
      category = newCategory;
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

  late String title;
  late String description = "";
  late String category = "Personal";
  late String priority = kPrimaryPriority;
  late String firstDate = DateTime.now().toString();
  bool descriptionIsVisible = false;
  DateTime? startDateSelected, endDateSelected;
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
                        IconButton(
                          icon: const Icon(Icons.calendar_month_outlined),
                          onPressed: () {
                            ShowDialog(
                                context: context,
                                onDateSelected: updateDate,
                                startDateSelected: startDateSelected);
                          },
                        ),
                      ],
                    ),
                  ),
                  Priority(
                    onPrioritySelected: updatePriority,
                    color: getPriorityColor(),
                  ),
                  CategoryDropDown(
                    onCategorySelected: updateCategory,
                  ),
                  IconButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        var task = TaskModel(
                          firstDate: firstDate,
                          priority: priority,
                          category: category,
                          title: title,
                          description: description,
                          isDone: false,
                        );
                        BlocProvider.of<AddTaskCubit>(context).addTask(task);
                        BlocProvider.of<TaskCubit>(context).fetchAllTasks();
                      } else {
                        setState(() {
                          autoValidate = AutovalidateMode.always;
                        });
                      }
                    },
                    icon: Icon(
                      Icons.arrow_forward_rounded,
                      color: Color(kPrimaryColor),
                    ),
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
