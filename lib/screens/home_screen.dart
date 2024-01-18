import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_app/controllers/launch_custom_tabs.dart';
import 'package:task_app/firebase_services.dart';
import 'package:task_app/variables/global_variables.dart';
import 'package:task_app/widgets/commonbox.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    // initPrefs(context);
    // fetchTasks();
  }

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

  Future<void> onItemTapped(int index) async {
    final _fireStoreService = FirestoreService();
    setState(() {
      _selectedIndex = index;
    });
    var linkMap = await _fireStoreService.bottomNavLinks();
    if (_selectedIndex == 0) {
      for (var element in linkMap.entries) {
        if (element.value.containsValue('redeem')) {
          var link = element.value['url'];
          launchCustomTabURL(link);
        }
      }
    }
    if (_selectedIndex == 1) {
      for (var element in linkMap.entries) {
        if (element.value.containsValue('history')) {
          var link = element.value['url'];
          launchCustomTabURL(link);
        }
      }
    }
    if (_selectedIndex == 2) {
      for (var element in linkMap.entries) {
        if (element.value.containsValue('spin')) {
          var link = element.value['url'];
          launchCustomTabURL(link);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 0),
                child: Container(
                  height: 58,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    //color: Colors.blue,
                    gradient: LinearGradient(
                        colors: [Color(0xff77767b), Color(0xff3c3b3e)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          "20000 coins = 400",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "Minimum Redeem = 400",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: TextButton(
                    onPressed: _refreshData,
                    style: TextButton.styleFrom(foregroundColor: Colors.white),
                    child: const Text('Tap to Refresh')),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2.5,
                    height: 50,
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 83, 80, 80)),
                    child: Column(
                      children: [
                        const Text('Total coins'),
                        Text(gameCoins.toString()),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2.5,
                    height: 50,
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 83, 80, 80)),
                    child: Column(
                      children: [
                        const Text('Total Value'),
                        Text((gameCoins / 50).toString()),
                      ],
                    ),
                  ),
                ],
              ),
              const CommonBox(
                text: "Spin & Win",
                width: 100,
                top: 20,
                width2: 120,
                text2: "Scratch & Win",
                route1: '/spin',
                route2: '/scratch',
                img1: 'assets/images/spingif1.png',
                img2: 'assets/images/win.png',
              ),
              const CommonBox(
                text: "Earn More",
                width: 100,
                top: 20,
                width2: 120,
                text2: "Task",
                route1: '/tasks',
                route2: '/tasks',
                img1: 'assets/task.png',
                img2: 'assets/task.png',
              ),
              // const CommonBox(
              //   text: "Earn More",
              //   width: 100,
              //   top: 20,
              //   width2: 120,
              //   text2: "Task",
              //   route1: '/tasks',
              //   route2: '/tasks',
              //   img1: 'assets/task.png',
              //   img2: 'assets/task.png',
              // ),
              // const CommonBox(
              //   text: "Earn More",
              //   width: 100,
              //   top: 20,
              //   width2: 120,
              //   text2: "Task",
              //   route1: '/tasks',
              //   route2: '/tasks',
              //   img1: 'assets/task.png',
              //   img2: 'assets/task.png',
              // ),

              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        side: const BorderSide(color: Colors.white, width: 5)),
                    onPressed: () {},
                    child: Container(
                      margin: EdgeInsets.all(5.0),
                      padding: EdgeInsets.all(5.0),
                      child: const Column(
                        children: [
                          Icon(Icons.contact_phone_rounded),
                          Text('Contact')
                        ],
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        side: const BorderSide(color: Colors.white, width: 5)),
                    onPressed: () {},
                    child: Container(
                      margin: EdgeInsets.all(5.0),
                      padding: EdgeInsets.all(5.0),
                      child: const Column(
                        children: [Icon(Icons.telegram), Text('Share')],
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        side: const BorderSide(color: Colors.white, width: 5)),
                    onPressed: () {},
                    child: Container(
                      margin: EdgeInsets.all(5.0),
                      padding: EdgeInsets.all(5.0),
                      child: const Column(
                        children: [
                          Icon(Icons.person_2_rounded),
                          Text('Profile')
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.redeem),
            label: 'Reedem',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Spin',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: onItemTapped,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
      ),
    );
  }
}
