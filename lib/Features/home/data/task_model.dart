import 'package:hive/hive.dart';
import 'package:to_do/constants.dart';
part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  String description;
  @HiveField(2)
  bool isDone;
  @HiveField(3)
  String firstDate;
  @HiveField(4)
  String priority;
  @HiveField(5)
  String category;
  TaskModel({
    required this.firstDate,
    this.priority = kPrimaryPriority,
    required this.category,
    required this.title,
    required this.description,
    this.isDone = false,
  });

  @override
  String toString() =>
      'TaskModel(title: $title, description: $description, isDone: $isDone, firstDate: $firstDate, priority: $priority, category: $category)';
}
