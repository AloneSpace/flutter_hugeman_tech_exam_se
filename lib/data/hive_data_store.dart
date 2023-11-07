import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../model/task.model.dart';

class HiveDataStore {
  static const boxName = "tasksBox";
  final Box<Task> box = Hive.box<Task>(boxName);

  /// Add new Task
  //coverage:ignore-start
  Future<void> addTask({required Task task}) async {
    if (task.id!.isNotEmpty && task.id != null) {
      await box.put(task.id, task);
    }
  }

  /// Show task
  Future<Task?> getTask({required String id}) async {
    return box.get(id);
  }

  /// Update task
  Future<void> updateTask({required Task task}) async {
    await task.save();
  }

  /// Delete task
  Future<void> deleteTask({required Task task}) async {
    if (task.id!.isNotEmpty && task.id != null) {
      await task.delete();
    }
  }

  ValueListenable<Box<Task>> listenToTask() {
    return box.listenable();
    //coverage:ignore-end
  }
}
