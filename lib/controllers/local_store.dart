import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_app/variables/global_variables.dart';

void initPrefs(context) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  if (prefs.containsKey(gameCoinsLabel)) {
    gameCoins = prefs.getInt(gameCoinsLabel)!;
  } else {
    prefs.setInt(gameCoinsLabel, 0);
    gameCoins = 0;
  }
  Navigator.popAndPushNamed(context, "/home");

  // gameCoins = prefs.getInt(gameCoinsLabel)!;
  // prefs.setInt(gameCoinsLabel, 0);
  // gameCoins = 0;

  // if (prefs.containsKey(spinChancesLabel)) {
  //   // spinsLeft = prefs.getInt(spinChancesLabel)!;
  //   // scratchLeft = prefs.getInt(scratchChancesLabel)!;
  //   if (prefs.containsKey(gameCoinsLabel)) {
  //     gameCoins = prefs.getInt(gameCoinsLabel)!;
  //   } else {
  //     prefs.setInt(gameCoinsLabel, 0);
  //     gameCoins = 0;
  //   }
  //   //redirect to home
  // } else {
  //   prefs.setInt(spinChancesLabel, 30);
  //   prefs.setInt(scratchChancesLabel, 30);
  //   initPrefs(context);
  // }
}

// Future<int> reduceTurn(String pref, int value) async {
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   prefs.setInt(pref, prefs.getInt(pref)! - value);
//   return prefs.getInt(pref)!;
// }

Future<int> increaseGameCoin(int value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  if (gameCoins > 19000) {
    prefs.setInt(gameCoinsLabel, prefs.getInt(gameCoinsLabel)! + 1);
    gameCoins = prefs.getInt(gameCoinsLabel)!;
  } else {
    prefs.setInt(gameCoinsLabel, prefs.getInt(gameCoinsLabel)! + value);
    gameCoins = prefs.getInt(gameCoinsLabel)!;
  }

  return gameCoins;
}
