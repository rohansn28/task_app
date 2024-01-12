import 'dart:async';

import 'package:flutter/material.dart';
import 'package:task_app/controllers/local_store.dart';
import 'package:task_app/screens/home_screen.dart';

class StartPg extends StatefulWidget {
  const StartPg({Key? key}) : super(key: key);

  @override
  State<StartPg> createState() => _StartPgState();
}

class _StartPgState extends State<StartPg> {
  late bool _isDisposed;
  @override
  void initState() {
    super.initState();
    _isDisposed = false;
    initPrefs(context);
    startTimer();
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  startTimer() async {
    var duration = const Duration(seconds: 4);
    return Timer(duration, route);
  }

  route() {
    if (!_isDisposed) {
      // Check if the widget is still mounted
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color.fromARGB(255, 149, 163, 211),
      child: Column(
        children: [
          const SizedBox(
            height: 180,
          ),
          Center(
            child: Container(
              height: 210,
              width: 220,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: const DecorationImage(
                    image: AssetImage("assets/images/logo1.png"),
                    fit: BoxFit.fill),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(9.0),
            child: Text(
              "Task app",
              textScaleFactor: 2.5,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                //fontSize: 60,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
