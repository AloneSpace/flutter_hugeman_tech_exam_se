import 'package:flutter/material.dart';
import 'package:flutter_hugeman_tech_exam_se/model/task.model.dart';
import 'package:flutter_hugeman_tech_exam_se/screens/main_screen.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  /// Initial Hive DB
  await Hive.initFlutter();

  /// Register Hive Adapter
  Hive.registerAdapter<Task>(TaskAdapter());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Random menu generator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        backgroundColor: Colors.green[200],
        textTheme: GoogleFonts.kanitTextTheme(),
      ),
      initialRoute: '/main',
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(name: '/main', page: () => const MainScreen()),
      ],
    );
  }
}
