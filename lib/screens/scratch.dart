import 'dart:math';

import 'package:flutter/material.dart';
import 'package:scratcher/widgets.dart';
import 'package:task_app/controllers/back_button_controller.dart';
import 'package:task_app/controllers/launchPopupScreen.dart';
import 'package:task_app/controllers/local_store.dart';
import 'package:task_app/screens/popup.dart';
import 'package:task_app/variables/global_variables.dart';
import 'package:task_app/widgets/commontopbar.dart';

class Scratch extends StatefulWidget {
  const Scratch({Key? key}) : super(key: key);

  @override
  State<Scratch> createState() => _ScratchState();
}

class _ScratchState extends State<Scratch> {
  final scratchKey = GlobalKey<ScratcherState>();

  int winPoint = 0;

  void setScratchReady() {
    setState(() {
      scratchKey.currentState?.reset(duration: const Duration(seconds: 1));
      winPoint = Random().nextInt(200);
    });
  }

  void onScratchCompleted(double value) async {
    if (value > 50) {
      scratchLeft = await reduceTurn(scratchChancesLabel, 1);
      gameCoins = await increaseGameCoin(winPoint);
      setState(() {
        launchPopupScreen(
            context,
            PopUp(
              coins: winPoint,
            ));
      });
      // showUnityInterstitial();
      setScratchReady();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setScratchReady();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        onBackPressed(context);
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          // bottomNavigationBar: applovinBanner(),
          backgroundColor: Colors.cyan.shade900,
          body: Column(
            children: [
              const CommonTop(left: 80, text: "SCRATCH"),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 45,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: const LinearGradient(
                            colors: [Color(0xfffa6b6b), Color(0xff7d3636)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter),
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 15, left: 11, right: 8),
                        child: Text(
                          "$scratchLeft Turn Left",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: Stack(
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
                                    image:
                                        AssetImage("assets/images/coin2.png"),
                                    fit: BoxFit.fill),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Scratcher(
                  key: scratchKey,
                  brushSize: 30,
                  threshold: 50,
                  color: Colors.transparent,
                  image: const Image(
                    image: AssetImage("assets/images/ground.png"),
                    fit: BoxFit.fill,
                  ),
                  onChange: onScratchCompleted,
                  child: Container(
                    height: 280,
                    width: 280,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      //border: Border.all(color: Colors.black)
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 150,
                          width: 180,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/images/success.png"),
                                fit: BoxFit.fill),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            "Congratulations!\nYou Won $winPoint Coins",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              // const CommonImage(
              //   top: 30,
              //   index: 1,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
