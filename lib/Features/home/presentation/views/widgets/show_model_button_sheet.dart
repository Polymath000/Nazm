import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/Features/Auth/presentation/views/widgets/loading_progress_h_u_d.dart';
import 'package:to_do/Features/Auth/presentation/views/widgets/show_snak_bar.dart';
import 'package:to_do/Features/home/data/cubit/add_task/add_task_cubit.dart';
import 'package:to_do/Features/home/data/cubit/task/task_cubit.dart';
import 'package:to_do/Features/home/presentation/views/widgets/add%20task/widgets/add_task_form.dart';

class ShowModelButtonSheet extends StatefulWidget {
  const ShowModelButtonSheet({super.key});
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
            return LoadingProgressHUD(
              isLoading: state is AddTaskLoading,
              child: AddTaskForm(),
            );
          },
        ),
      ),
    );
  }
}
