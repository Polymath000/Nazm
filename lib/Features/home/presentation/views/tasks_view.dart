import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:to_do/Features/home/presentation/views/widgets/add%20task/sample_date_picker.dart';
import 'package:to_do/Features/home/presentation/views/widgets/category_drop_down.dart';
import 'package:to_do/Features/home/presentation/views/widgets/priority.dart';

class TasksView extends StatefulWidget {
  const TasksView({super.key});

  @override
  State<TasksView> createState() => _TasksViewState();
}

class _TasksViewState extends State<TasksView> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          tooltip: 'add Task',
          enableFeedback: true,
          child: const Icon(Icons.add_task_sharp),
          onPressed: () {
            showModalBottomSheet(
                barrierLabel: 'Task',
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                context: context,
                builder: (context) {
                  return const ShowModelButtonSheet();
                });
          }),
    );
  }
}

class ShowModelButtonSheet extends StatefulWidget {
  const ShowModelButtonSheet({super.key});
  @override
  State<ShowModelButtonSheet> createState() => _ShowModelButtonSheetState();
}

class _ShowModelButtonSheetState extends State<ShowModelButtonSheet> {
  bool descriptionIsVisible = false;
  DateTime? startDateSelected, endDateSelected;
  final GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autoValidate = AutovalidateMode.disabled;

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
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Field is required';
                  } else {
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
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Field is required';
                    } else {
                      return null;
                    }
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
                  SampleDatePicker(),
                  Priority(),
                  CategoryDropDown(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
