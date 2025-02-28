import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:to_do/Features/home/data/task_model.dart';
import 'package:to_do/constants.dart';
part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());

  List<TaskModel> tasks = [];

  List<TaskModel> fetchAllTasks() {
    tasks = Hive.box<TaskModel>(kTaskBox).values.toList();
    emit(TaskSuccess(tasks: tasks));
    return tasks;
  }
}
