import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_app/variables/global_variables.dart';
import 'package:task_app/widgets/commonbox.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await _refreshData();
        },
        child: SingleChildScrollView(
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
                const SizedBox(
                  height: 16.0,
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
                    text2: "Task"),
                const CommonBox(
                    text: "Spin & Win",
                    width: 100,
                    top: 20,
                    width2: 120,
                    text2: "Task"),
                const CommonBox(
                    text: "Spin & Win",
                    width: 100,
                    top: 20,
                    width2: 120,
                    text2: "Task"),
                const CommonBox(
                    text: "Spin & Win",
                    width: 100,
                    top: 20,
                    width2: 120,
                    text2: "Task"),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: const Column(
                        children: [
                          Icon(Icons.contact_phone_rounded),
                          Text('Contact')
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Column(
                        children: [Icon(Icons.telegram), Text('Share')],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Column(
                        children: [
                          Icon(Icons.person_2_rounded),
                          Text('Profile')
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
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
      ),
    );
  }
}
