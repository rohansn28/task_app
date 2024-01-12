import 'package:flutter/material.dart';
import 'package:task_app/firebase_services.dart';
import 'package:task_app/variables/global_variables.dart';
import 'package:task_app/widgets/commontask.dart';
// import 'package:task_app/widgets/commontask.dart';
import 'package:task_app/widgets/commontopbar.dart';

class TasksScreen extends StatefulWidget {
  final int? initialCoins;
  const TasksScreen({super.key, this.initialCoins});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  final FirestoreService _firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // onBackPressed(context);

        Navigator.pop(context, gameCoins);

        return true;
      },
      child: Scaffold(
        backgroundColor:
            const Color.fromARGB(255, 43, 43, 43), //Colors.cyan.shade900,
        // bottomNavigationBar: applovinBanner(),
        body: ListView(
          children: [
            const CommonTop(left: 50, text: "DAILY TASK"),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Container(
                          height: 30,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: const LinearGradient(
                                colors: [Color(0xff77767b), Color(0xff3c3b3e)],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(gameCoins.toString(),
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                )),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Container(
                          height: 45,
                          width: 45,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            //color: Colors.white,
                            image: DecorationImage(
                                image: AssetImage("assets/images/coin2.png"),
                                fit: BoxFit.fill),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: const Color(0xff00001b),
                  border: Border.all(color: const Color(0xff707070), width: 3),
                ),
                child: const Center(
                  child: Text("Visit Site and Stay 30 sec & Win 100 Coins Each",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      )),
                ),
              ),
            ),
            FutureBuilder<List<String>>(
              future: _firestoreService.getLinks(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: Text('Loading...'));
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  List<String> links = snapshot.data ?? [];
                  return Column(
                    children: links.map((link) {
                      return CommonTask(top: 20, index: 0, url: link);
                    }).toList(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
