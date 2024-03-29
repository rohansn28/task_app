import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_app/controllers/launchPopupScreen.dart';
import 'package:task_app/controllers/launch_custom_tabs.dart';
import 'package:task_app/controllers/local_store.dart';
import 'package:task_app/controllers/show_snackbar.dart';
import 'package:task_app/firebase_services.dart';
import 'package:task_app/screens/popup.dart';
import 'package:task_app/widgets/time_remaining_widget.dart';

class ResumeTrackingScreen extends StatefulWidget {
  const ResumeTrackingScreen({Key? key}) : super(key: key);

  @override
  State<ResumeTrackingScreen> createState() => _ResumeTrackingScreenState();
}

class _ResumeTrackingScreenState extends State<ResumeTrackingScreen>
    with WidgetsBindingObserver {
  final FirestoreService _firestoreService = FirestoreService();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String seconds = "";
  String type = "";
  String id = "";

  // late String documentId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  Future<String> getUrlId(String targetUrl) async {
    var data = await _firestoreService.fetchDocuments();
    for (var element in data.entries) {
      if (element.value['url'] == targetUrl) {
        return element.key;
      }
    }
    return '';
  }

  void setPrefs(
      String link, String coin, String seconds, String type, String id) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString("currentLink", link);
    prefs.setString(
        link,
        DateTime.now()
            .add(Duration(seconds: int.parse(seconds)))
            .toUtc()
            .toString());
    prefs.setString("coin", coin);
    prefs.setString("type", type);
    prefs.setString("id", id);
  }

  void checkPrefs() async {
    final SharedPreferences prefs = await _prefs;
    if (DateTime.parse(prefs.getString(prefs.getString("currentLink")!)!)
        .toUtc()
        .isAfter(DateTime.now().toUtc())) {
      // before time
      int timeLeft =
          DateTime.parse(prefs.getString(prefs.getString("currentLink")!)!)
              .difference(DateTime.now().toUtc())
              .inSeconds;
      timeRemainingHandle(timeLeft.toString(), prefs.getString("coin")!,
          prefs.getString("currentLink")!);
    } else {
      // after time
      winnerHandle(int.parse(prefs.getString("coin")!));
      //firebase update field
      var urlId = await getUrlId(prefs.getString("currentLink")!);
      await FirebaseFirestore.instance
          .collection('links')
          .doc(urlId)
          .update({'disable': true, 'urllastclicktime': DateTime.now()});
    }
  }

  void winnerHandle(int coin) {
    Navigator.pop(context);
    List<int> winList = [60, 60, 250, 100, 80, 40, 250, 60, 60, 100, 100, 60];
    int z = Random().nextInt(winList.length);
    increaseGameCoin(winList[z]);
    showSnackBar(context, "You Won ${winList[z]} Coins");
    launchPopupScreen(context, PopUp(coins: winList[z]));
    //launchPopupScreen(context, WinPanelWidget(coins: coin,reason: type,));
  }

  void timeRemainingHandle(String timeLeftSeconds, String coin, String link) {
    Navigator.pop(context);
    showSnackBar(context, "Please Wait 1 min on the website");
    launchPopupScreen(
        context,
        TimeRemainingWidget(
          seconds: timeLeftSeconds,
          coins: coin,
          link: link,
          type: type,
          id: id,
        ));
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      checkPrefs();
    }
  }

  void _launchLink(
      String link, String coin, String seconds, String type, String id) {
    setPrefs(link, coin, seconds, type, id);
    launchCustomTabURL(link);
  }

  @override
  Widget build(BuildContext context) {
    final routes =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final link = routes['link'];
    final coin = routes['coin'];
    seconds = routes['seconds']!;
    type = routes['type']!;
    id = routes['id']!;
    (link!);
    _launchLink(link, coin!, seconds, type, id);
    return Scaffold(
      backgroundColor: Colors.cyan.shade900,
      body: const Center(
          child: Text(
        "Please Wait...",
        style: TextStyle(color: Colors.white),
      )),
    );
  }
}
