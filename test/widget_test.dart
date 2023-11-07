// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_hugeman_tech_exam_se/data/hive_data_store.dart';
import 'package:flutter_hugeman_tech_exam_se/model/task.model.dart';
import 'package:flutter_hugeman_tech_exam_se/screens/main_screen.dart';
import 'package:flutter_hugeman_tech_exam_se/widgets/rounded-input.widget.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_hugeman_tech_exam_se/main.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:io';

void initHive() {
  var path = Directory.current.path;
  Hive.init('$path/test/hive_testing_path');
}

void main() async {
  initHive();
  Hive.registerAdapter<Task>(TaskAdapter());
  Hive.registerAdapter<TaskStatus>(TaskStatusAdapter());
  var box = await Hive.openBox<Task>("tasksBox");

  testWidgets("Create RoundedInput", (WidgetTester tester) async {
    final RoundedInputWidget roundedInputWidget = RoundedInputWidget(
      textController: TextEditingController(),
      hintText: "Test",
      onChanged: (String value) {},
    );
    await tester.pumpWidget(roundedInputWidget);

    final hintTextFinder = find.text("Test");
    expect(hintTextFinder, findsOneWidget);
  });

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());
  });

  test("Hive data should add, update, get", () async {
    final dataStore = HiveDataStore();

    dataStore.addTask(
        task: Task.create(title: "Test", description: "Test description"));

    dataStore.updateTask(
        task: Task.create(
      title: "Test",
      description: "Test description",
    ));

    final task = await dataStore.getTask(id: "1");
    if (task != null) {
      expect(task.title, "Test");
    }
  });

  test("Hive data should delete", () async {
    final dataStore = HiveDataStore();

    dataStore.addTask(
        task: Task.create(title: "Test", description: "Test description"));

    dataStore.deleteTask(
        task: Task.create(
      title: "Test",
      description: "Test description",
    ));

    final task = await dataStore.getTask(id: "1");
    expect(task, null);
  });
}
