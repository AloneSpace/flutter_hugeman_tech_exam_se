import 'package:animate_do/animate_do.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hugeman_tech_exam_se/constants/constants.dart';
import 'package:flutter_hugeman_tech_exam_se/constants/strings.dart';
import 'package:flutter_hugeman_tech_exam_se/data/hive_data_store.dart';
import 'package:flutter_hugeman_tech_exam_se/model/task.model.dart';
import 'package:flutter_hugeman_tech_exam_se/widgets/rounded-input.widget.dart';
import 'package:flutter_hugeman_tech_exam_se/widgets/task_item.widget.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final HiveDataStore dataStore = HiveDataStore();

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  Future<void> openAddTask(Task? task) async {
    titleController.text = '';
    descriptionController.text = '';
    if (task != null) {
      titleController.text = task.title;
      descriptionController.text = task.description;
    }
    Size size = MediaQuery.of(context).size;
    Rx<bool> onSubmit = false.obs;
    await showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext bottomContext, StateSetter mystate) {
            return SingleChildScrollView(
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    height: MediaQuery.of(context).size.height / 2.7 +
                        MediaQuery.of(context).viewInsets.bottom,
                    child: Wrap(
                      runSpacing: 8,
                      children: <Widget>[
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  MyString.bottomAddTaskTitle,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                padding:
                                    EdgeInsets.only(bottom: size.height * 0.02),
                              ),
                            ]),
                        Obx(
                          () => RoundedInputWidget(
                              textController: titleController,
                              hintText: 'Title',
                              icon: Icons.text_fields_outlined,
                              requiredInput: true,
                              isSubmitted: onSubmit.value,
                              onChanged: (value) => {
                                    mystate(() {
                                      titleController.text = value;
                                    })
                                  }),
                        ),
                        Obx(
                          () => RoundedInputWidget(
                              textController: descriptionController,
                              hintText: 'Description',
                              icon: Icons.description,
                              isSubmitted: onSubmit.value,
                              requiredInput: true,
                              onChanged: (value) => {
                                    mystate(() {
                                      descriptionController.text = value;
                                    })
                                  }),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: size.height * 0.02,
                          ),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                color: Colors.green,
                                height: size.height * 0.05,
                                width: size.width * 0.9,
                                child: TextButton(
                                  onPressed: () async {
                                    setState(() {
                                      onSubmit.value = true;
                                      if (titleController.text.isNotEmpty &&
                                          descriptionController
                                              .text.isNotEmpty) {
                                        dataStore.addTask(
                                            task: Task.create(
                                                title: titleController.text,
                                                description:
                                                    descriptionController
                                                        .text));
                                        Navigator.pop(context);
                                      }
                                    });
                                  },
                                  child: Text(
                                    "Submit",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              )),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 10,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          color: Colors.white,
                          width: 32,
                          height: 32,
                          child: Icon(Icons.close, color: Colors.red[700]),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          });
        });
  }

  Future<void> openDeleteDialog(Task? task) async {
    AwesomeDialog(
      context: context,
      title: MyString.titleDeleteTaskDialog,
      desc: MyString.descDeleteTaskDialog,
      dialogType: DialogType.warning,
      btnCancelText: "Cancel",
      btnOkText: "OK",
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        dataStore.deleteTask(task: task!);
      },
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ValueListenableBuilder(
        valueListenable: dataStore.listenToTask(),
        builder: (ctx, Box<Task> box, Widget? child) {
          var tasks = box.values.toList();

          /// Sort Task List
          tasks.sort(((a, b) => a.createdAt.compareTo(b.createdAt)));

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
                              MyString.mainTitle + ' (${tasks.length})',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 585,
                            child: tasks.isNotEmpty
                                ? ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: tasks.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      var task = tasks[index];

                                      return TaskItemWidget(
                                        task: task,
                                        onTaskChanged: (task) {
                                          task.status = TaskStatus.completed;
                                          dataStore.updateTask(task: task);
                                        },
                                        onDeleteItem: (task) {
                                          openDeleteDialog(task);
                                        },
                                      );
                                    },
                                  )

                                /// if All Tasks Done Show this Widgets
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      /// Lottie
                                      FadeInDown(
                                        child: SizedBox(
                                          width: 300,
                                          height: 300,
                                          child: Image.asset(
                                            checkListVector,
                                          ),
                                        ),
                                      ),

                                      /// Bottom Texts
                                      FadeInUp(
                                        from: 30,
                                        child: const Text(MyString.doneAllTask,
                                            style: TextStyle(fontSize: 20)),
                                      ),
                                    ],
                                  ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            backgroundColor: Colors.grey[300],
            floatingActionButton: FloatingActionButton(
              elevation: 0,
              onPressed: () {
                openAddTask(null);
              },
              child: Icon(Icons.add),
            ),
          );
        });
  }
}
