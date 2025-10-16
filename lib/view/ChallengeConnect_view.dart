
import 'package:flutter/material.dart';
import 'package:ludo/view/LudoLoading_view.dart';


class ChallengeConnectScreen extends StatelessWidget {
  const ChallengeConnectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(0, 8, 15, 1), // Background color
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Challenge & Connect",
          style: TextStyle(color: Colors.yellowAccent),
        ),
        leading: const BackButton(color: Colors.yellowAccent),
        actions: [
          Icon(Icons.wallet, color: Colors.yellowAccent,)
        ],
      ),
    
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GameCard(
              title: "Want Her Heart?\nKhelo Aur Jeeto!❤️",
              subtitle: "Win the match to unlock 1:1 audio call at 50% OFF!",
              entryCoins: 25,
              image: "assets/icon/ludo1.png",
            ),
            const SizedBox(height: 20),
            GameCard(
              title: "Jeeto Coins & Dil Ka Connection",
              subtitle: "Win & Earn coins plus 50% off on 1:1 call!",
              entryCoins: 50,
              image: "assets/icon/ludo2.png",
            ),
          ],
        ),
      ),
    
    );
  }
}
class GameCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final int entryCoins;
  final String image;

  const GameCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.entryCoins,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          colors: [
            Color.fromRGBO(245, 221, 46, 1),
            Color.fromRGBO(228, 157, 18, 1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Container(
        margin: const EdgeInsets.all(3), // Thickness of the gradient border
        decoration: BoxDecoration(
          color: const Color.fromRGBO(0, 8, 15, 1),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.6),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(subtitle,
                        style: const TextStyle(
                            color: Colors.white70, fontSize: 14)),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.monetization_on,
                                color: Colors.yellowAccent),
                            const SizedBox(width: 4),
                            Text("$entryCoins Coins",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.greenAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const LudoLoadingScreen()));
                          },
                          child: const Text(
                            "Play Now",
                            style: TextStyle(color: Colors.black),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Image.asset(
                image,
                height: 100,
                width: 100,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
