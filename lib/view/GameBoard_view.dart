// ignore_for_file: curly_braces_in_flow_control_structures, deprecated_member_use

import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ludo/provider/game_board_provider.dart';
import 'package:ludo/view/widget/RingsPainter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GameBoardScreen extends StatelessWidget {
  const GameBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690), 
      builder: (context, child) {
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
                          SizedBox(height: 12.h),
                          Expanded(
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                final boardSize = min(
                                  constraints.maxWidth - 40.w,
                                  constraints.maxHeight * 0.62,
                                );
                                return Column(
                                  children: [
                                    Center(
                                      child: _buildBoardArea(provider, boardSize),
                                    ),
                                    SizedBox(height: 12.h),
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
      },
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.25),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Row(
              children: [
                Icon(Icons.emoji_events, color: Colors.amber, size: 18.sp),
                SizedBox(width: 6.w),
                Text(
                  '350',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(6.w),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Image.asset(
                  'assets/images/dice.png',
                  width: 28.w,
                  height: 28.h,
                ),
              ),
              SizedBox(width: 8.w),
              CircleAvatar(
                radius: 18.r,
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
      width: size.w,
      height: size.h,
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: Colors.transparent,
        border: Border.all(color: Colors.orange.shade700, width: 6.w),
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
            top: 8.h,
            right: 12.w,
            child: _playerMiniCard('Nirmal', 'assets/images/profile.png'),
          ),
          Positioned(
            bottom: 8.h,
            left: 12.w,
            child: _playerMiniCard('Anika', 'assets/images/profile.png'),
          ),
          Positioned(
            bottom: 8.h,
            right: 12.w,
            child: _powerUpCard(),
          ),
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
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.36),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          Image.asset('assets/images/dice.png', width: 20.w, height: 20.h),
          SizedBox(width: 8.w),
          CircleAvatar(radius: 14.r, backgroundImage: AssetImage(avatarAsset)),
          SizedBox(width: 8.w),
          Text(name, style: TextStyle(color: Colors.white, fontSize: 12.sp)),
        ],
      ),
    );
  }

  Widget _powerUpCard() {
    return Container(
      padding: EdgeInsets.all(6.w),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.36),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          Image.asset('assets/images/dice.png', width: 22.w, height: 22.h),
          SizedBox(width: 8.w),
          Text(
            '4 Power Up',
            style: TextStyle(color: Colors.white, fontSize: 12.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomEmojiBar(BuildContext context) {
    final emojis = ['😎', '🎁', '😄', '😂', '😒', '😍'];
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 10.w),
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
                  margin: EdgeInsets.symmetric(horizontal: 8.w),
                  width: 56.w,
                  height: 56.h,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  child: Center(
                    child: Text(e, style: TextStyle(fontSize: 28.sp)),
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
            padding: EdgeInsets.all(18.w),
            backgroundColor: Colors.redAccent,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/images/bottomm.png', width: 48.w, height: 48.h),
              SizedBox(height: 4.h),
              Text(
                provider.lastDice == 0 ? 'Roll' : provider.lastDice.toString(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
              ),
            ],
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          'Turn: ${provider.currentTurn[0].toUpperCase()}${provider.currentTurn.substring(1)}',
          style: TextStyle(color: Colors.white70, fontSize: 14.sp),
        ),
      ],
    );
  }
}
