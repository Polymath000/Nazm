import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:to_do/Features/home/data/task_model.dart';
import 'package:to_do/constants.dart';

part 'add_task_state.dart';

class AddTaskCubit extends Cubit<AddTaskState> {
  AddTaskCubit() : super(AddTaskInitial());

  Future<void> addTask(TaskModel task) async {
    emit(AddTaskLoading());
    try {
      var taskBox = Hive.box<TaskModel>(kTaskBox);
      await taskBox.add(task);
      for (int i = 0; i < taskBox.length; i++) {
        debugPrint('${taskBox.getAt(i).toString()} \n');
      }
      emit(AddTaskSuccess());
    } on Exception catch (e) {
      emit(AddTaskFailure(e.toString()));
    }
  }
}
