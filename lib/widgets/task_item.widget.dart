import 'package:flutter/material.dart';
import 'package:flutter_hugeman_tech_exam_se/constants/colors.dart';
import 'package:flutter_hugeman_tech_exam_se/model/task.model.dart';
import 'package:intl/intl.dart';

class TaskItemWidget extends StatelessWidget {
  final Task task;
  final Function(Task) onTaskChanged;
  final Function(Task) onDeleteItem;

  const TaskItemWidget({
    Key? key,
    required this.task,
    required this.onTaskChanged,
    required this.onDeleteItem,
  });

  bool isStatusCompleted(Task task) {
    return task.status == TaskStatus.completed;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: isStatusCompleted(task) ? Colors.grey[400] : Colors.white,
      ),
      child: ListTile(
        onTap: () {
          onTaskChanged(task);
        },
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              task.description,
              style: TextStyle(
                fontSize: 12,
                color: tdBlack,
                decoration:
                    isStatusCompleted(task) ? TextDecoration.lineThrough : null,
              ),
            ),
            Text(
              DateFormat('dd/MM/yyyy').format(task.createdAt),
              style: TextStyle(
                fontSize: 10,
                color: tdGrey,
              ),
            ),
          ],
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
              onDeleteItem(task);
            },
          ),
        ),
      ),
    );
  }
}
