import 'package:flutter/material.dart';
import 'package:flutter_hugeman_tech_exam_se/model/task.model.dart';
import 'package:flutter_hugeman_tech_exam_se/widgets/task_item.widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // SizedBox(
              //   height: size.height * 0.2,
              // ),
              Expanded(
                child: ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        top: 50,
                        bottom: 20,
                      ),
                      child: Text(
                        'All ToDos',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    TaskItemWidget(
                        task: Task.create(title: "", description: ""),
                        onTaskChanged: () {},
                        onDeleteItem: () {})
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      backgroundColor: Colors.grey[300],
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
