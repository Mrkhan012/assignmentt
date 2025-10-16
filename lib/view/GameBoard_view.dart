// ignore_for_file: curly_braces_in_flow_control_structures, deprecated_member_use

import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ludo/provider/game_board_provider.dart';
import 'package:ludo/view/widget/RingsPainter.dart';
import 'package:provider/provider.dart';


class GameBoardScreen extends StatelessWidget {
  const GameBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GameBoardProvider(),
      child: Consumer<GameBoardProvider>(
        builder: (_, provider, __) {
          return Scaffold(
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
                    imageFilter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                    child: Container(color: Colors.black.withOpacity(0.45)),
                  ),
                ),
                SafeArea(
                  child: Column(
                    children: [
                      _buildTopBar(),
                      const SizedBox(height: 12),
                      Expanded(
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            final boardSize = min(
                              constraints.maxWidth - 40,
                              constraints.maxHeight * 0.62,
                            );
                            return Column(
                              children: [
                                Center(
                                  child: _buildBoardArea(provider, boardSize),
                                ),
                                const SizedBox(height: 12),
                                _buildDiceAndTimerArea(provider),
                                const Spacer(),
                                _buildBottomEmojiBar(context),
                              ],
                            );
                          },
                        ),
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

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.25),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: const [
                Icon(Icons.emoji_events, color: Colors.amber, size: 18),
                SizedBox(width: 6),
                Text(
                  '350',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.asset(
                  'assets/images/dice.png',
                  width: 28,
                  height: 28,
                ),
              ),
              const SizedBox(width: 8),
              CircleAvatar(
                radius: 18,
                backgroundImage: AssetImage('assets/images/avatar1.png'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBoardArea(GameBoardProvider provider, double size) {
    return Container(
      width: size,
      height: size,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.transparent,
        border: Border.all(color: Colors.orange.shade700, width: 6),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/ludo_board.jpg',
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            top: 8,
            right: 12,
            child: _playerMiniCard('Nirmal', 'assets/images/profile.png'),
          ),
          Positioned(
            bottom: 8,
            left: 12,
            child: _playerMiniCard('Anika', 'assets/images/profile.png'),
          ),
          Positioned(bottom: 8, right: 12, child: _powerUpCard()),
          Positioned.fill(
            child: CustomPaint(
              painter: TokenPainter(tokenPos: provider.tokenPos),
            ),
          ),
        ],
      ),
    );
  }

  Widget _playerMiniCard(String name, String avatarAsset) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.36),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Image.asset('assets/images/dice.png', width: 20, height: 20),
          const SizedBox(width: 8),
          CircleAvatar(radius: 14, backgroundImage: AssetImage(avatarAsset)),
          const SizedBox(width: 8),
          Text(name, style: const TextStyle(color: Colors.white, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _powerUpCard() {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.36),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Image.asset('assets/images/dice.png', width: 22, height: 22),
          const SizedBox(width: 8),
          const Text(
            '4 Power Up',
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomEmojiBar(BuildContext context) {
    final emojis = ['😎', '🎁', '😄', '😂', '😒', '😍'];
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            for (var e in emojis)
              GestureDetector(
                onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Sent $e'),
                    duration: const Duration(milliseconds: 600),
                  ),
                ),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text(e, style: const TextStyle(fontSize: 28)),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDiceAndTimerArea(GameBoardProvider provider) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: provider.rollDice,
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(18),
            backgroundColor: Colors.redAccent,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/images/bottomm.png', width: 48, height: 48),
              const SizedBox(height: 4),
              Text(
                provider.lastDice == 0 ? 'Roll' : provider.lastDice.toString(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Turn: ${provider.currentTurn[0].toUpperCase()}${provider.currentTurn.substring(1)}',
          style: const TextStyle(color: Colors.white70),
        ),
      ],
    );
  }
}



