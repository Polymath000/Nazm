import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:to_do/Features/home/data/task_model.dart';
import 'package:to_do/constants.dart';

part 'add_task_state.dart';

class AddTaskCubit extends Cubit<AddTaskState> {
  AddTaskCubit() : super(AddTaskInitial());
  bool isLoading = false;
  addTask(TaskModel task) async {
    emit(AddTaskLoading());
    try {
      var taskBox = Hive.box<TaskModel>(kTaskBox);
      await taskBox.add(task);
      print(taskBox.values);
      emit(AddTaskSuccess());
    } on Exception catch (e) {
      emit(AddTaskFailure(e.toString()));
    }
  }
}
