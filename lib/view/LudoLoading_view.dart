import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:ludo/provider/loading_provider.dart';
import 'package:ludo/view/Match_view.dart';
import 'package:ludo/view/widget/PillProgressBar.dart';
import 'package:ludo/view/widget/RingsPainter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LudoLoadingScreen extends StatelessWidget {
  const LudoLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690), // replace with your Figma design size
      builder: (context, child) {
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
                    SizedBox(height: 60.h),
                    Image.asset(
                      'assets/images/dice_crown.png',
                      width: 100.w,
                      height: 100.h,
                    ),
                    SizedBox(height: 36.h),
                    SizedBox(
                      width: 300.w,
                      height: 300.h,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CustomPaint(
                              size: Size(300.w, 300.h), painter: RingsPainter()),
                          CircleAvatar(
                            radius: 40.r,
                            backgroundImage:
                                AssetImage('assets/avatars/avatar2.png'),
                          ),
                          Positioned(
                            top: 20.h,
                            child: CircleAvatar(
                              radius: 25.r,
                              backgroundImage:
                                  AssetImage('assets/avatars/avatar1.png'),
                            ),
                          ),
                          Positioned(
                            right: 20.w,
                            child: CircleAvatar(
                              radius: 25.r,
                              backgroundImage:
                                  AssetImage('assets/avatars/avatar3.png'),
                            ),
                          ),
                          Positioned(
                            bottom: 20.h,
                            child: CircleAvatar(
                              radius: 25.r,
                              backgroundImage:
                                  AssetImage('assets/avatars/avatar2.png'),
                            ),
                          ),
                          Positioned(
                            left: 20.w,
                            child: CircleAvatar(
                              radius: 25.r,
                              backgroundImage:
                                  AssetImage('assets/avatars/avatar1.png'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 28.h),
                    Text(
                      'Loading...',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40.w),
                      child: SizedBox(
                        height: 22.h,
                        child: Consumer<LoadingProvider>(
                          builder: (_, provider, __) {
                            return PillProgressBar(
                              progress: provider.progress,
                              stripeOffset: provider.progress * 0.5,
                            );
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
      },
    );
  }
}
