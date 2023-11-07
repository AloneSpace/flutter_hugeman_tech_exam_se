import 'package:flutter/material.dart';
import 'package:flutter_hugeman_tech_exam_se/constants/colors.dart';
import 'package:flutter_hugeman_tech_exam_se/model/task.model.dart';

class TaskItemWidget extends StatelessWidget {
  final Task task;
  final Function onTaskChanged;
  final Function onDeleteItem;

  const TaskItemWidget({
    Key? key,
    required this.task,
    required this.onTaskChanged,
    required this.onDeleteItem,
  });

  bool isStatusCompleted(Task task) {
    return task.status.name == TodoStatus.completed.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          // print('Clicked on task Item.');
          onTaskChanged(task);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: Colors.white,
        leading: Icon(
          isStatusCompleted(task)
              ? Icons.check_box
              : Icons.check_box_outline_blank,
          color: tdBlue,
        ),
        title: Text(
          task.title,
          style: TextStyle(
            fontSize: 16,
            color: tdBlack,
            decoration:
                isStatusCompleted(task) ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Container(
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.symmetric(vertical: 12),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: tdRed,
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            color: Colors.white,
            iconSize: 18,
            icon: Icon(Icons.delete),
            onPressed: () {
              // print('Clicked on delete icon');
              onDeleteItem(task.id);
            },
          ),
        ),
      ),
    );
  }
}
