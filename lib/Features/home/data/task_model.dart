import 'package:hive/hive.dart';
import 'package:to_do/constants.dart';
part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel extends HiveObject {
  @HiveField(0)
  late final String title;
  @HiveField(1)
  final String description;
  @HiveField(2)
  bool isDone;
  @HiveField(3)
  final String firstDate;
  @HiveField(4)
  final String lastDate;
  @HiveField(5)
  String priority;
  @HiveField(6)
  final String category;
  TaskModel({
    required this.firstDate,
    required this.lastDate,
    this.priority = kPrimaryPriority,
    required this.category,
    required this.title,
    required this.description,
    this.isDone = false,
  });

  @override
  String toString() =>
      'TaskModel(title: $title, description: $description, isDone: $isDone, firstDate: $firstDate, lastDate: $lastDate, priority: $priority, category: $category)';
}
