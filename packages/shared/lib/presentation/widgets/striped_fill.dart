import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';

const _stripeWidth = Spacing.borderWidthMedium;
const _stripePeriod = Spacing.xxs;

class const StripedFill({
  super.key,
  required final Color _color,
  required final Color _background,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _StripePainter(color: _color, background: _background),
      child: const SizedBox.expand(),
    );
  }
}

class const _StripePainter({
  required final Color _color,
  required final Color _background,
}) extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, Paint()..color = _background);
    final stripe = Paint()
      ..color = _color
      ..strokeWidth = _stripeWidth;
    for (var x = -size.height; x < size.width; x += _stripePeriod) {
      canvas.drawLine(Offset(x, size.height), Offset(x + size.height, 0), stripe);
    }
  }

  @override
  bool shouldRepaint(_StripePainter oldDelegate) =>
      oldDelegate._color != _color || oldDelegate._background != _background;
}
