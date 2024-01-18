import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_app/variables/global_variables.dart';
import 'package:task_app/widgets/commontask.dart';
import 'package:task_app/widgets/commontopbar.dart';

class TasksScreen extends StatefulWidget {
  final int? initialCoins;
  const TasksScreen({super.key, this.initialCoins});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  Future<void> _refreshData() async {
    // Fetch updated data from shared preferences

    int updatedCoins = await SharedPreferences.getInstance().then((prefs) {
      return prefs.getInt(gameCoinsLabel) ?? 0;
    });

    // Update UI
    setState(() {
      gameCoins = updatedCoins;
    });
  }

  Future checkData(String urlId) async {
    await FirebaseFirestore.instance
        .collection('links')
        .doc(urlId)
        .update({'disable': false, 'urllastclicktime': ''});
  }

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
        body: RefreshIndicator(
          onRefresh: () async {
            await _refreshData();
          },
          child: ListView(
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
                                  colors: [
                                    Color(0xff77767b),
                                    Color(0xff3c3b3e)
                                  ],
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
                    border:
                        Border.all(color: const Color(0xff707070), width: 3),
                  ),
                  child: const Center(
                    child:
                        Text("Visit Site and Stay 30 sec & Win 100 Coins Each",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            )),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Text(
                  'Pull down to Refresh',
                  textAlign: TextAlign.center,
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('links').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  List<DocumentSnapshot> documents = snapshot.data!.docs;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: documents.map((document) {
                      Map<String, dynamic> documentData =
                          document.data() as Map<String, dynamic>;
                      String documentId = document.id;

                      if (!documentData['disable']) {
                        return CommonTask(
                          documentId: documentId,
                          top: 20,
                          index: 0,
                          url: documentData['url'],
                        );
                      } else {
                        try {
                          var urlClickTimeStamp =
                              documentData['urllastclicktime'];
                          DateTime urlClickTimeFormatted =
                              DateTime.fromMillisecondsSinceEpoch(
                            urlClickTimeStamp.seconds * 1000 +
                                urlClickTimeStamp.nanoseconds ~/ 1000000,
                          );

                          if (DateTime.now()
                                  .difference(urlClickTimeFormatted)
                                  .inSeconds >
                              60) {
                            checkData(documentId);
                          }
                        } catch (e) {
                          print(e);
                        }
                        return SizedBox();
                      }
                    }).toList(),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
