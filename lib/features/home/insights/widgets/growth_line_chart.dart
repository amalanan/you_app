import 'package:flutter/material.dart';
import 'package:you_app/core/helpers/extensions.dart';
import '../../../../core/constants/app_colors.dart';
import '../models/growth_detail.dart';

/// Simple line chart (no package): green line, dots and labels under each dot.
class GrowthLineChart extends StatelessWidget {
  const GrowthLineChart({super.key, required this.points, this.height = 150});

  final List<GrowthPoint> points;
  final double height;

  static const _pad = 14.0;

  @override
  Widget build(BuildContext context) {
    final labelStyle = context.text.bodySmall
        ?.copyWith(fontSize: 11, color: context.mutedText);

    return LayoutBuilder(
      builder: (context, c) {
        final w = c.maxWidth;
        final n = points.length;
        double x(int i) => n == 1 ? w / 2 : _pad + i * (w - 2 * _pad) / (n - 1);

        return Column(
          children: [
            SizedBox(
              height: height,
              width: w,
              child: CustomPaint(
                painter: _ChartPainter(
                  values: [for (final p in points) p.value],
                  pad: _pad,
                  lineColor: AppColors.primary,
                  baseColor: context.borderColor,
                ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 16,
              width: w,
              child: Stack(
                children: [
                  for (var i = 0; i < n; i++)
                    Positioned(
                      left: x(i) - 20,
                      width: 40,
                      child: Center(child: Text(points[i].label, style: labelStyle)),
                    ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ChartPainter extends CustomPainter {
  _ChartPainter({
    required this.values,
    required this.pad,
    required this.lineColor,
    required this.baseColor,
  });

  final List<int> values;
  final double pad;
  final Color lineColor;
  final Color baseColor;

  @override
  void paint(Canvas canvas, Size size) {
    if (values.isEmpty) return;

    final minV = values.reduce((a, b) => a < b ? a : b) - 4;
    final maxV = values.reduce((a, b) => a > b ? a : b) + 4;
    final range = (maxV - minV).toDouble();
    final n = values.length;

    Offset at(int i) {
      final dx = n == 1 ? size.width / 2 : pad + i * (size.width - 2 * pad) / (n - 1);
      final dy = size.height - ((values[i] - minV) / range) * (size.height - 2 * pad) - pad;
      return Offset(dx, dy);
    }

    // baseline
    canvas.drawLine(
      Offset(0, size.height - 1),
      Offset(size.width, size.height - 1),
      Paint()
        ..color = baseColor
        ..strokeWidth = 1,
    );

    final path = Path()..moveTo(at(0).dx, at(0).dy);
    for (var i = 1; i < n; i++) {
      path.lineTo(at(i).dx, at(i).dy);
    }
    canvas.drawPath(
      path,
      Paint()
        ..color = lineColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5
        ..strokeJoin = StrokeJoin.round
        ..strokeCap = StrokeCap.round,
    );

    final dot = Paint()..color = lineColor;
    for (var i = 0; i < n; i++) {
      canvas.drawCircle(at(i), 4.5, dot);
    }
  }

  @override
  bool shouldRepaint(covariant _ChartPainter old) =>
      old.values != values || old.lineColor != lineColor || old.baseColor != baseColor;
}
