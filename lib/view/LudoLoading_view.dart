



import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ludo/provider/loading_provider.dart';
import 'package:ludo/view/Match_view.dart';
import 'package:ludo/view/widget/PillProgressBar.dart';
import 'package:ludo/view/widget/RingsPainter.dart';
import 'package:provider/provider.dart';

class LudoLoadingScreen extends StatelessWidget {
  const LudoLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoadingProvider()..startLoading(() {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const MatchScreen()),
        );
      }),
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/backgoud.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned.fill(
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                child: Container(color: Colors.black.withOpacity(0.28)),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 60),
                Image.asset('assets/images/dice_crown.png', width: 100, height: 100),
                const SizedBox(height: 36),
                SizedBox(
                  width: 300,
                  height: 300,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CustomPaint(size: const Size(300, 300), painter: RingsPainter()),
                      CircleAvatar(radius: 40, backgroundImage: AssetImage('assets/avatars/avatar2.png')),
                      Positioned(top: 20, child: CircleAvatar(radius: 25, backgroundImage: AssetImage('assets/avatars/avatar1.png'))),
                      Positioned(right: 20, child: CircleAvatar(radius: 25, backgroundImage: AssetImage('assets/avatars/avatar3.png'))),
                      Positioned(bottom: 20, child: CircleAvatar(radius: 25, backgroundImage: AssetImage('assets/avatars/avatar2.png'))),
                      Positioned(left: 20, child: CircleAvatar(radius: 25, backgroundImage: AssetImage('assets/avatars/avatar1.png'))),
                    ],
                  ),
                ),
                const SizedBox(height: 28),
                const Text('Loading...', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600)),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: SizedBox(
                    height: 22,
                    child: Consumer<LoadingProvider>(
                      builder: (_, provider, __) {
                        return PillProgressBar(progress: provider.progress, stripeOffset: provider.progress * 0.5);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
