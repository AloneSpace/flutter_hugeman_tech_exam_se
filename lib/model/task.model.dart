import 'package:uuid/uuid.dart';
import 'package:hive/hive.dart';

part 'task.model.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  Task(
      {this.id,
      required this.title,
      required this.description,
      //*Not reqiored createdAt
      required this.createdAt,
      this.status});

  /// ID
  @HiveField(0)
  final String? id;

  /// TITLE
  @HiveField(1)
  String title;

  /// description
  @HiveField(2)
  String description;

  /// CREATED AT TIME
  @HiveField(3)
  DateTime createdAt;

  /// STATUS
  @HiveField(4)
  TodoStatus? status;

  /// create new Task
  factory Task.create({
    required String? title,
    required String? description,
    DateTime? createdAt,
  }) =>
      Task(
        id: const Uuid().v4(),
        title: title ?? "",
        description: description ?? "",
        createdAt: createdAt ?? DateTime.now(),
        status: TodoStatus.inProgress,
      );
}

enum TodoStatus {
  inProgress,
  completed,
}
