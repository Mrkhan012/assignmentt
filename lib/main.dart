import 'package:flutter/material.dart';
import 'package:ludo/view/ChallengeConnect_view.dart';
import 'package:ludo/view/LudoLoading_view.dart';
import 'package:ludo/view/Match_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/challenge',
      routes: {
        '/challenge': (context) => const ChallengeConnectScreen(),
        '/ludoLoading': (context) => const LudoLoadingScreen(),
        '/matchview': (context) => const MatchScreen(),
      },
    );
  }
}
