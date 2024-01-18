import 'package:flutter/material.dart';

class CommonDisableBox extends StatefulWidget {
  final double top;
  final String tasktime;
  const CommonDisableBox({
    Key? key,
    required this.tasktime,
    required this.top,
  }) : super(key: key);

  @override
  State<CommonDisableBox> createState() => _CommonTaskState();
}

class _CommonTaskState extends State<CommonDisableBox> {
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
              "Next Task Will be availabe in",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18),
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width - 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  color: const Color.fromARGB(255, 231, 61, 149),
                  border: Border.all(color: Colors.black),
                ),
                child: Center(
                    child: Text(
                  widget.tasktime,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.black, fontSize: 24),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
