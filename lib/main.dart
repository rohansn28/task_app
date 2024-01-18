import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:task_app/firebase_options.dart';
import 'package:task_app/screens/home_screen.dart';
import 'package:task_app/screens/resume_tracking_screen.dart';
import 'package:task_app/screens/scratch.dart';
import 'package:task_app/screens/spin.dart';
import 'package:task_app/screens/start_page.dart';
import 'package:task_app/screens/tasks_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await MobileAds.instance.initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.black),
      routes: {
        "/": (context) => const StartPg(),
        "/home": (context) => const HomeScreen(),
        "/tasks": (context) => TasksScreen(),
        "/tracking": (context) => const ResumeTrackingScreen(),
        "/spin": (context) => const Spin(),
        "/scratch": (context) => const Scratch(),
      },
    );
  }
}
