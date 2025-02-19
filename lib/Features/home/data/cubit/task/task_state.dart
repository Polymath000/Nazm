part of 'task_cubit.dart';

@immutable
sealed class TaskState {}

final class TaskInitial extends TaskState {}

final class TaskSuccess extends TaskState {
  final List<TaskModel> tasks;
  TaskSuccess({required this.tasks});
}

final class TaskFailure extends TaskState {
  final String errorMessage;
  TaskFailure({required this.errorMessage});
}
