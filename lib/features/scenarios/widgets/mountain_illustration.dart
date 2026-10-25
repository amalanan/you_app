import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

/// Drawn in code (your result.svg was split in two and very low resolution).
/// Replace with a proper SVG/PNG export whenever you have one.
class MountainIllustration extends StatelessWidget {
  const MountainIllustration({super.key, this.height = 130});

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: CustomPaint(painter: _MountainPainter()),
    );
  }
}

class _MountainPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // clouds
    final cloud = Paint()..color = AppColors.logoPurple.withAlpha(60);
    void drawCloud(double cx, double cy, double r) {
      canvas.drawCircle(Offset(cx, cy), r, cloud);
      canvas.drawCircle(Offset(cx - r * 1.1, cy + r * 0.3), r * 0.7, cloud);
      canvas.drawCircle(Offset(cx + r * 1.1, cy + r * 0.3), r * 0.75, cloud);
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(cx - r * 1.8, cy + r * 0.3, r * 3.6, r * 0.8),
          Radius.circular(r * 0.4),
        ),
        cloud,
      );
    }

    drawCloud(w * 0.18, h * 0.3, h * 0.12);
    drawCloud(w * 0.84, h * 0.5, h * 0.09);

    // back mountain
    final back = Path()
      ..moveTo(w * 0.42, h)
      ..lineTo(w * 0.62, h * 0.4)
      ..lineTo(w * 0.69, h * 0.48)
      ..lineTo(w * 0.76, h * 0.36)
      ..lineTo(w * 0.98, h)
      ..close();
    canvas.drawPath(back, Paint()..color = AppColors.secondary.withAlpha(140));

    // main mountain
    final main = Path()
      ..moveTo(w * 0.14, h)
      ..lineTo(w * 0.42, h * 0.3)
      ..lineTo(w * 0.48, h * 0.38)
      ..lineTo(w * 0.55, h * 0.32)
      ..lineTo(w * 0.82, h)
      ..close();
    canvas.drawPath(
      main,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF6B6D80), Color(0xFF45465A)],
        ).createShader(Rect.fromLTWH(0, 0, w, h)),
    );

    // flag
    final peak = Offset(w * 0.42, h * 0.3);
    final top = Offset(peak.dx, h * 0.04);
    canvas.drawLine(
      peak,
      top,
      Paint()
        ..color = const Color(0xFF3F4152)
        ..strokeWidth = 2.5
        ..strokeCap = StrokeCap.round,
    );
    final flag = Path()
      ..moveTo(top.dx, top.dy)
      ..lineTo(top.dx + w * 0.1, top.dy)
      ..lineTo(top.dx + w * 0.085, top.dy + h * 0.075)
      ..lineTo(top.dx + w * 0.1, top.dy + h * 0.15)
      ..lineTo(top.dx, top.dy + h * 0.15)
      ..close();
    canvas.drawPath(flag, Paint()..color = AppColors.primary);

    // leaves
    final leaf = Paint()..color = AppColors.primary.withAlpha(170);
    void drawLeaf(double cx, double angle) {
      canvas.save();
      canvas.translate(cx, h);
      canvas.rotate(angle);
      canvas.drawOval(Rect.fromCenter(center: Offset(0, -h * 0.1), width: w * 0.03, height: h * 0.22), leaf);
      canvas.restore();
    }

    drawLeaf(w * 0.08, -0.4);
    drawLeaf(w * 0.11, 0.1);
    drawLeaf(w * 0.9, 0.35);
    drawLeaf(w * 0.93, -0.1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
