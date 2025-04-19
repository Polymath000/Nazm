import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/Features/home/data/cubit/task/task_cubit.dart';
import 'package:to_do/Features/home/presentation/views/widgets/add_task_buttom.dart';
import 'package:to_do/Features/home/presentation/views/widgets/app_bar_of_profile.dart';
import 'package:to_do/Features/home/presentation/views/widgets/calender_widget.dart';
import 'package:to_do/Features/home/presentation/views/widgets/show_model_button_sheet.dart';

class CalenderView extends StatelessWidget {
  const CalenderView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskCubit(),
      child: const Calender(),
    );
  }
}

class Calender extends StatefulWidget {
  const Calender({super.key});

  @override
  _CalenderState createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  int index = 2;
  late DateTime selectedDate;
  void updateDate(DateTime date) {
    setState(() {
      selectedDate = date;
    });
  }

  @override
  void initState() {
    selectedDate = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(23.0),
        child: Column(
          children: [
            const AppBarOfProfile(),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        index = 1;
                      });
                    },
                    child: Text(
                      'Week',
                      style: TextStyle(
                          color: index == 1 ? Colors.blue : Colors.grey,
                          fontSize: 20),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        index = 2;
                      });
                    },
                    child: Text(
                      'Month',
                      style: TextStyle(
                          color: index == 2 ? Colors.blue : Colors.grey,
                          fontSize: 20),
                    ),
                  ),
                  AddTaskButtom(
                    onPressed: () {
                      showModalBottomSheet(
                          barrierLabel: 'Task',
                          isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          context: context,
                          builder: (context) {
                            return ShowModelButtonSheet(
                              date: selectedDate,
                            );
                          });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height / 1.8,
              child: CalenderWidget(
                key: ValueKey<int>(index),
                index: index,
                updateDate: updateDate,
                today: selectedDate,
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
