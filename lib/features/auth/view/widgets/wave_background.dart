import 'package:flutter/widgets.dart';

class WaveBackground extends StatelessWidget {
  const WaveBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(child: CustomPaint(painter: _WavePainter()));
  }
}

class _WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paintPrimary = Paint()
      ..color = const Color(0xFF00464F).withOpacity(0.15)
      ..style = PaintingStyle.fill;

    final pathPrimary = Path();

    // Ola verde
    pathPrimary.moveTo(0, size.height * 0.40);
    pathPrimary.cubicTo(
      size.width * 0.2,
      size.height * 0.35,
      size.width * 0.4,
      size.height * 0.55,
      size.width * 0.6,
      size.height * 0.45,
    );

    pathPrimary.cubicTo(
      size.width * 0.8,
      size.height * 0.35,
      size.width,
      size.height * 0.50,
      size.width,
      size.height * 0.45,
    );
    pathPrimary.lineTo(size.width, size.height);
    pathPrimary.lineTo(0, size.height);
    pathPrimary.close();

    canvas.drawPath(pathPrimary, paintPrimary);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
