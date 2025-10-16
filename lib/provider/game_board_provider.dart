
import 'dart:math';

import 'package:flutter/material.dart';

class GameBoardProvider extends ChangeNotifier {
  Map<String, int> tokenPos = {'red': 0, 'green': 0, 'blue': 0, 'yellow': 0};
  String currentTurn = 'red';
  int lastDice = 0;
  final Random _rng = Random();

  void rollDice() {
    final v = _rng.nextInt(6) + 1;
    tokenPos[currentTurn] = (tokenPos[currentTurn]! + v) % 16;
    lastDice = v;
    currentTurn = _nextTurn(currentTurn);
    notifyListeners();
  }

  String _nextTurn(String t) {
    if (t == 'red') return 'green';
    if (t == 'green') return 'blue';
    if (t == 'blue') return 'yellow';
    return 'red';
  }
}

class GameProvider extends ChangeNotifier {
  int selectedEntryCoins = 0;

  void selectGame(int coins) {
    selectedEntryCoins = coins;
    notifyListeners();
  }
}

