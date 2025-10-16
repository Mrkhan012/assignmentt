

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ludo/provider/match_provider.dart';
import 'package:ludo/view/GameBoard_view.dart';
import 'package:provider/provider.dart';


class MatchScreen extends StatelessWidget {
  const MatchScreen({super.key});

  String twoDigits(int n) => n.toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MatchProvider()..startCountdown(() {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const GameBoardScreen()));
      }),
      child: Consumer<MatchProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            body: Stack(
              children: [
                Container(decoration: const BoxDecoration(
                    image: DecorationImage(image: AssetImage('assets/images/backgoud.png'), fit: BoxFit.cover))),
                Positioned.fill(
                    child: ImageFiltered(
                        imageFilter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                        child: Container(color: Colors.black.withOpacity(0.45)))),
                SafeArea(
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      Center(child: Image.asset('assets/images/dice_crown.png', width: 120, height: 120)),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 28.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                CircleAvatar(radius: 40, backgroundImage: AssetImage('assets/avatars/avatar1.png')),
                                const SizedBox(height: 8),
                                const Text('Juliee', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16))
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                                  decoration: BoxDecoration(
                                    boxShadow: [BoxShadow(color: Colors.orange.withOpacity(0.65), blurRadius: 18, spreadRadius: 1)],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Text('VS', style: TextStyle(color: Colors.yellowAccent, fontSize: 26, fontWeight: FontWeight.w900)),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                CircleAvatar(radius: 40, backgroundImage: AssetImage('assets/avatars/avatar2.png')),
                                const SizedBox(height: 8),
                                const Text('Rocky', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16))
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Column(
                        children: [
                          Image.asset('assets/images/bottomm.png', width: 92, height: 92),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.timer, color: Colors.amber, size: 18),
                              const SizedBox(width: 6),
                              Text('00:${twoDigits(provider.remaining)}',
                                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14)),
                            ],
                          ),
                          const SizedBox(height: 36),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}