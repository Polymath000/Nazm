import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:to_do/Features/home/presentation/views/widgets/add%20task/sample_date_picker.dart';
import 'package:to_do/Features/home/presentation/views/widgets/priority.dart';

class TasksView extends StatefulWidget {
  const TasksView({super.key});

  @override
  State<TasksView> createState() => _TasksViewState();
}

class _TasksViewState extends State<TasksView> {
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

  @override
  Widget build(BuildContext context) {
    return Form(
      child: SingleChildScrollView(
        child: Container(
          height: MediaQuery.sizeOf(context).height / 1.5,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TextField(
                minLines: 1,
                maxLines: 3,
                autofocus: true,
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
                child: const TextField(
                  minLines: 1,
                  maxLines: 3,
                  autofocus: true,
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
                  Priority()
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
