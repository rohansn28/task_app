import 'package:flutter/material.dart';

class CommonTask extends StatefulWidget {
  final double top;
  final int index;
  final String url;
  final String documentId;

  const CommonTask({
    Key? key,
    required this.top,
    required this.index,
    required this.url,
    required this.documentId,
  }) : super(key: key);

  @override
  State<CommonTask> createState() => _CommonTaskState();
}

class _CommonTaskState extends State<CommonTask> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      ///reuse
      padding: EdgeInsets.only(top: widget.top, left: 20, right: 20),
      child: Container(
        height: 110,
        width: 400,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: const Color.fromARGB(255, 136, 166, 255),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Visit Site and Stay 30 sec & Win 100 Coins Each",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18),
              child: InkWell(
                onTap: () async {
                  Navigator.pushNamed(context, '/tracking', arguments: {
                    "link": widget.url,
                    "coin": "50",
                    "seconds": "10",
                    "type": "task",
                    "id": widget.index.toString(),
                  });
                },
                child: Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width - 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    color: const Color.fromARGB(255, 231, 61, 149),
                    border: Border.all(color: Colors.black),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Text(
                          "Start",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Container(
                        height: 35,
                        width: 38,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/clicker.png"),
                            fit: BoxFit.fill,
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
    );
  }
}
