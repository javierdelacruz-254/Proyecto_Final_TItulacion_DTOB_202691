import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lactaamor/core/theme/app_colors.dart';

class ParticlesBackground extends StatefulWidget {
  const ParticlesBackground({super.key});

  @override
  State<ParticlesBackground> createState() => _ParticlesBackgroundState();
}

class _ParticlesBackgroundState extends State<ParticlesBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Random random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) {
          return CustomPaint(painter: _ParticlesPainter(_controller.value));
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _ParticlesPainter extends CustomPainter {
  final double progress;
  final Random random = Random();

  _ParticlesPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    for (int i = 0; i < 25; i++) {
      double x = random.nextDouble() * size.width;
      double y = (random.nextDouble() * size.height) - (progress * size.height);

      double opacity = (1 - progress).clamp(0.0, 1.0);

      paint.color = AppColors.secondary.withOpacity(opacity * 0.4);

      canvas.drawCircle(Offset(x, y % size.height), 4, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
