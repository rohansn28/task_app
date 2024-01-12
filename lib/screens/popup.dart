import 'package:flutter/material.dart';

class PopUp extends StatefulWidget {
  final int coins;
  const PopUp({Key? key, required this.coins}) : super(key: key);

  @override
  State<PopUp> createState() => _PopUpState();
}

class _PopUpState extends State<PopUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.8),
      body: Center(
        child: Container(
          height: 250,
          width: MediaQuery.of(context).size.width - 50,
          decoration: BoxDecoration(
              color: const Color(0xff3a433ff4).withOpacity(0.6),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.white, width: 5)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 0, right: 10, bottom: 0),
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                    image: DecorationImage(
                        image: AssetImage("assets/images/trophy.png"),
                        fit: BoxFit.fill),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10, top: 0),
                    child: Text(
                      "Congratulations...\nYou Won ${widget.coins} Coins",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 0, left: 0),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) => const TasksScreen()));
                        // showApplovinRewardedAds();
                        // showUnityInterstitial();
                      },
                      child: Container(
                        height: 45,
                        width: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(0xff9ed395),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.only(top: 9),
                          child: Text(
                            "Continue",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
