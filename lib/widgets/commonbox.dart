import 'package:flutter/material.dart';
// import 'package:taskwin/controllers/launch_custom_tab.dart';

class CommonBox extends StatelessWidget {
  final String text;
  final String img1;
  final double width;
  final double top;
  final double width2;
  final String text2;
  final String img2;
  final String route1, route2;
  const CommonBox({
    Key? key,
    required this.text,
    required this.img1,
    required this.width,
    required this.top,
    required this.width2,
    required this.text2,
    required this.img2,
    required this.route1,
    required this.route2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: top, left: 0, right: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () {
              // if(route1.contains('http')){
              //   launchCustomTabURL(route1);
              // }else{
              //   Navigator.pushNamed(context, route1);
              // }
              Navigator.pushNamed(context, route1);
            },
            child: Container(
              width: MediaQuery.of(context).size.width / 2.5,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.black),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 8),
                child: Column(
                  children: [
                    Container(
                      height: 80,
                      decoration: BoxDecoration(
                        //color: Colors.green,
                        image: DecorationImage(
                            image: AssetImage(img1), fit: BoxFit.contain),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: InkWell(
                        child: Container(
                          height: 30,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: const LinearGradient(
                                colors: [Color(0xff77767b), Color(0xff3c3b3e)],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter),
                          ),
                          child: Center(
                            child: Text(
                              text,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          ///
          InkWell(
            onTap: () {
              // if(route2.contains('http')){
              //   launchCustomTabURL(route2);
              // }else{
              //   Navigator.pushNamed(context, route2);
              // }
              Navigator.pushNamed(context, route2);
            },
            child: Container(
              width: MediaQuery.of(context).size.width / 2.5,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.black),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 8),
                child: Column(
                  children: [
                    Container(
                      height: 80,
                      decoration: BoxDecoration(
                        //color: Colors.green,
                        image: DecorationImage(
                            image: AssetImage(img2), fit: BoxFit.contain),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: InkWell(
                        child: Container(
                          height: 30,
                          width: MediaQuery.of(context).size.width / 2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: const LinearGradient(
                                colors: [Color(0xff77767b), Color(0xff3c3b3e)],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter),
                          ),
                          child: Center(
                            child: Text(
                              text2,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
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
    );
  }
}
