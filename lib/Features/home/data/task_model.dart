import 'package:hive/hive.dart';
part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel extends HiveObject {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String description;
  @HiveField(2)
  final bool isDone;
  @HiveField(3)
  final String firstDate;
  @HiveField(4)
  final String lastDate;
  @HiveField(5)
  final String priority;
  @HiveField(6)
  final String category;
  TaskModel({
    required this.firstDate,
    required this.lastDate,
    required this.priority,
    required this.category,
    required this.title,
    required this.description,
    required this.isDone,
  });

  @override
  String toString() =>
      'TaskModel(title: $title, description: $description, isDone: $isDone, firstDate: $firstDate, lastDate: $lastDate, priority: $priority, category: $category)';
}
