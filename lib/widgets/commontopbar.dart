import 'package:flutter/material.dart';

class CommonTop extends StatelessWidget {
  final double left;
  final String text;
  const CommonTop({Key? key, required this.left, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [Color(0xff77767b), Color(0xff3c3b3e)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 40),
        child: Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);

                // showApplovinInterstitialAds();
              },
              child: Container(
                height: 40,
                width: 40,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  image: DecorationImage(
                      image: AssetImage("assets/images/left.png"),
                      fit: BoxFit.fill),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: left),
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
