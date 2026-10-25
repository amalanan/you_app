import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

/// Little plant in a pot, drawn in code (replace with an SVG/PNG when you have one).
class PlantIllustration extends StatelessWidget {
  const PlantIllustration({super.key, this.height = 120});

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: CustomPaint(painter: _PlantPainter()),
    );
  }
}

class _PlantPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final cx = w / 2;

    // soft glow behind the plant
    canvas.drawCircle(
      Offset(cx, h * 0.55),
      h * 0.5,
      Paint()..color = AppColors.logoPurple.withAlpha(35),
    );

    // sparkles
    void sparkle(double x, double y, double r) {
      final p = Path()
        ..moveTo(x, y - r)
        ..quadraticBezierTo(x, y, x + r, y)
        ..quadraticBezierTo(x, y, x, y + r)
        ..quadraticBezierTo(x, y, x - r, y)
        ..quadraticBezierTo(x, y, x, y - r)
        ..close();
      canvas.drawPath(p, Paint()..color = AppColors.logoPurple.withAlpha(150));
    }

    sparkle(cx - h * 0.55, h * 0.25, h * 0.06);
    sparkle(cx + h * 0.5, h * 0.15, h * 0.08);
    sparkle(cx + h * 0.62, h * 0.45, h * 0.04);

    // stem
    final stemTop = Offset(cx, h * 0.38);
    final stemBase = Offset(cx, h * 0.68);
    canvas.drawLine(
      stemBase,
      stemTop,
      Paint()
        ..color = AppColors.primary
        ..strokeWidth = 3
        ..strokeCap = StrokeCap.round,
    );

    // leaves
    void leaf(Offset base, double angle, double len, double wd, Color c) {
      canvas.save();
      canvas.translate(base.dx, base.dy);
      canvas.rotate(angle);
      final p = Path()
        ..moveTo(0, 0)
        ..quadraticBezierTo(wd, -len * 0.5, 0, -len)
        ..quadraticBezierTo(-wd, -len * 0.5, 0, 0)
        ..close();
      canvas.drawPath(p, Paint()..color = c);
      canvas.restore();
    }

    const dark = AppColors.primary;
    final light = AppColors.primary.withAlpha(170);
    leaf(stemTop, 0, h * 0.26, h * 0.1, dark);
    leaf(Offset(cx, h * 0.52), -0.9, h * 0.3, h * 0.1, light);
    leaf(Offset(cx, h * 0.52), 0.9, h * 0.3, h * 0.1, dark);
    leaf(stemBase, -0.5, h * 0.24, h * 0.08, dark);
    leaf(stemBase, 0.5, h * 0.24, h * 0.08, light);

    // pot
    final potW = h * 0.5;
    final potTop = h * 0.66;
    final pot = Path()
      ..moveTo(cx - potW / 2, potTop)
      ..lineTo(cx + potW / 2, potTop)
      ..lineTo(cx + potW * 0.38, h * 0.97)
      ..quadraticBezierTo(cx, h * 1.0, cx - potW * 0.38, h * 0.97)
      ..close();
    canvas.drawPath(pot, Paint()..color = const Color(0xFF6F6A8E));
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(cx, potTop),
          width: potW * 1.08,
          height: h * 0.07,
        ),
        const Radius.circular(4),
      ),
      Paint()..color = const Color(0xFF8B86AD),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
