




import 'dart:math';

import 'package:flutter/material.dart';

/// ------------------- REUSABLE PAINTERS -------------------

class RingsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white24
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    final center = Offset(size.width / 2, size.height / 2);
    final radii = [50.0, 80.0, 110.0, 140.0];
    for (var r in radii) canvas.drawCircle(center, r, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class TokenPainter extends CustomPainter {
  final Map<String, int> tokenPos;
  TokenPainter({required this.tokenPos});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2 - 28;
    final players = {
      'red': Colors.red,
      'green': Colors.green,
      'blue': Colors.blue,
      'yellow': Colors.yellow,
    };
    int i = 0;
    for (var entry in players.entries) {
      final posIndex = tokenPos[entry.key] ?? 0;
      final angle = (2 * pi * (posIndex / 16)) + (i * pi / 2);
      final p = Offset(
        center.dx + radius * cos(angle),
        center.dy + radius * sin(angle),
      );
      paint.color = entry.value;
      canvas.drawCircle(p, 8, paint);
      i++;
    }
  }

  @override
  bool shouldRepaint(covariant TokenPainter oldDelegate) =>
      oldDelegate.tokenPos != tokenPos;
}