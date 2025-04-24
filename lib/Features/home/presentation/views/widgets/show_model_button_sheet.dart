// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/Features/Auth/presentation/views/widgets/loading_progress_h_u_d.dart';
import 'package:to_do/Features/Auth/presentation/views/widgets/show_snak_bar.dart';
import 'package:to_do/Features/home/data/cubit/add_task/add_task_cubit.dart';
import 'package:to_do/Features/home/data/cubit/task/task_cubit.dart';
import 'package:to_do/Features/home/presentation/views/widgets/add%20task/widgets/add_task_form.dart';

class ShowModelButtonSheet extends StatefulWidget {
  const ShowModelButtonSheet({super.key, required this.date});
  final DateTime date;
  @override
  State<ShowModelButtonSheet> createState() => _ShowModelButtonSheetState();
}

class _ShowModelButtonSheetState extends State<ShowModelButtonSheet> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AddTaskCubit()),
        BlocProvider(create: (context) => TaskCubit()),
      ],
      child: _ShowModelButtonSheetContent(date: widget.date),
    );
  }
}

class _ShowModelButtonSheetContent extends StatefulWidget {
  const _ShowModelButtonSheetContent({required this.date});
  final DateTime date;

  @override
  State<_ShowModelButtonSheetContent> createState() =>
      _ShowModelButtonSheetContentState();
}

class _ShowModelButtonSheetContentState
    extends State<_ShowModelButtonSheetContent> {
  bool isSaving = false;

  void returnSavingvariableFromAddTaskForm(bool data) {
    setState(() {
      isSaving = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return !isSaving;
      },
      child: BlocListener<AddTaskCubit, AddTaskState>(
        listener: (context, state) {
          if (state is AddTaskSuccess) {
            BlocProvider.of<TaskCubit>(context).fetchAllTasks();
            Navigator.pop(context);
          } else if (state is AddTaskFailure) {
            ShowSnakBar(context, state.errorMessage.toString());
          }
        },
        child: BlocBuilder<AddTaskCubit, AddTaskState>(
          builder: (context, state) {
            return Stack(
              children: [
                AbsorbPointer(
                  absorbing: state is AddTaskLoading || isSaving,
                  child: AddTaskForm(
                    date: widget.date,
                    updateSavingvariable: returnSavingvariableFromAddTaskForm,
                  ),
                ),
                if (state is AddTaskLoading || isSaving)
                  Positioned.fill(
                    child: Container(
                      color: Colors.black.withOpacity(0.5),
                      child: const Center(),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
