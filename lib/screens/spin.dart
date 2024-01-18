import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:task_app/controllers/back_button_controller.dart';
import 'package:task_app/controllers/launchPopupScreen.dart';
import 'package:task_app/controllers/local_store.dart';
import 'package:task_app/controllers/show_snackbar.dart';
import 'package:task_app/screens/popup.dart';
import 'package:task_app/variables/global_variables.dart';
import 'package:task_app/widgets/commontopbar.dart';

class Spin extends StatefulWidget {
  const Spin({Key? key}) : super(key: key);

  @override
  State<Spin> createState() => _SpinState();
}

class _SpinState extends State<Spin> with SingleTickerProviderStateMixin {
  ///it will support all kind of animations

  late AnimationController _animationController;

  ///it will help in functionality of animation like start,stop
  late Animation<double> _animation;

  ///it will help in performing types of animation like scale or curve

  late Timer _timer;

  int winPoint = 0;
  List<double> degreeList = [
    130,
    130,
    145,
    154,
    155,
    156,
    158,
    162,
    162,
    154,
    154,
    162
  ];
  List<int> winList = [60, 60, 250, 100, 80, 40, 250, 60, 60, 100, 100, 60];

  void startRotation() {
    int z = Random().nextInt(11);
    double stopPoint = degreeList[z];
    winPoint = winList[z];

    setState(() {
      ///this code is for setting spin animation
      _animation = Tween(begin: 0.0, end: stopPoint).animate(CurvedAnimation(
          parent: _animationController, curve: Curves.decelerate));

      ///it will run an animation from fast to slow using decelerate
    });

    if (_animationController.isAnimating) {
    } else {
      _animationController.reset();
      _animationController.forward();
      onSpinWheelStop();

      ///forward means to start
    }
  }

  void onSpinWheelStop() {
    _timer = Timer(const Duration(milliseconds: 5000), () async {
      spinsLeft = await reduceTurn(spinChancesLabel, 1);
      gameCoins = await increaseGameCoin(winPoint);
      setState(() {
        // showUnityInterstitial();
        launchPopupScreen(
            context,
            PopUp(
              coins: winPoint,
            ));
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
      vsync: this,

      ///vsync means it give exact time to animation according to android timing
      duration: const Duration(milliseconds: 5000),
    );

    _animation = Tween(begin: 0.0).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.decelerate));
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
          body: ListView(
            children: [
              const CommonTop(left: 100, text: "SPIN"),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 45,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                            colors: [Color(0xfffa6b6b), Color(0xff7d3636)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, bottom: 6),
                              child: Text(
                                "$spinsLeft Turn Left",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 4, bottom: 8),
                              child: Container(
                                height: 80,
                                width: 50,
                                decoration: const BoxDecoration(
                                  color: Colors.transparent,
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/fortunewheel.png"),
                                      fit: BoxFit.fill),
                                ),
                              ),
                            ),
                          ],
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
                padding: const EdgeInsets.only(top: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 320,
                      width: 320,
                      alignment: Alignment.center,
                      child: Stack(
                        children: [
                          Center(
                            child: SizedBox(
                              height: 300,
                              width: 300,
                              child: Center(
                                child: AnimatedBuilder(
                                    animation: _animation,
                                    child: const Image(
                                      image: AssetImage(
                                          "assets/images/Spinwheeltaskwin.png"),
                                      fit: BoxFit.fill,
                                    ),
                                    builder: (context, child) {
                                      return Transform.rotate(
                                        angle: _animation.value,
                                        child: child,
                                      );
                                    }),
                              ),
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/spinwehelcover.png"),
                                  fit: BoxFit.fill),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 45,
                                width: 45,
                                decoration: const BoxDecoration(
                                  color: Colors.transparent,
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/Polygon.png"),
                                      fit: BoxFit.fill),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        if (spinsLeft > 0) {
                          startRotation();
                        } else {
                          showSnackBar(context, "Today's Chances Over");
                        }
                      },
                      child: Container(
                        height: 50,
                        width: 170,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(26),
                            gradient: const LinearGradient(
                                colors: [Color(0xff77767b), Color(0xff3c3b3e)],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 35),
                          child: Row(
                            children: [
                              const Text(
                                "SPIN",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  height: 60,
                                  width: 50,
                                  decoration: const BoxDecoration(
                                    color: Colors.transparent,
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/clicker.png"),
                                        fit: BoxFit.fill),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // const CommonImage(
              //   top: 30,
              //   index: 0,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
