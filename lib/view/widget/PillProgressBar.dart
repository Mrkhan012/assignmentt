




import 'package:flutter/material.dart';

class PillProgressBar extends StatelessWidget {
  final double progress;
  final double stripeOffset;
  const PillProgressBar({required this.progress, required this.stripeOffset, super.key});
  @override
  Widget build(BuildContext context) {
    final trackColor = Colors.white24;
    final fillBaseColor = Colors.blueAccent;
    return LayoutBuilder(builder: (context, constraints) {
      final fullWidth = constraints.maxWidth;
      final filledWidth = fullWidth * progress;
      return ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: Stack(children: [
          Container(width: fullWidth, height: double.infinity, color: trackColor),
          Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: filledWidth < 2 ? 0 : filledWidth,
              height: double.infinity,
              child: Stack(fit: StackFit.expand, children: [
                Container(color: fillBaseColor.withOpacity(0.95)),
                Transform.translate(
                  offset: Offset((stripeOffset - 1.0) * 80, 0),
                  child: Transform.rotate(
                    angle: -0.6,
                    child: FractionallySizedBox(
                      widthFactor: 2.5,
                      heightFactor: 2.5,
                      alignment: Alignment.centerLeft,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.white.withOpacity(0.18),
                              Colors.transparent,
                              Colors.white.withOpacity(0.18),
                              Colors.transparent,
                            ],
                            stops: const [0.0, 0.25, 0.5, 0.75],
                            tileMode: TileMode.repeated,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(width: 6, decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.white.withOpacity(0.25), Colors.transparent]))),
                )
              ]),
            ),
          ),
          Container(width: fullWidth, height: double.infinity, decoration: BoxDecoration(borderRadius: BorderRadius.circular(40), border: Border.all(color: Colors.white24, width: 2))),
        ]),
      );
    });
  }
}
