import 'package:flutter/cupertino.dart';

class DashedBorderPainter extends CustomPainter {
  final Color color;
  final double containerWidth;
  double dashWidth;
  double dashSpace;

  DashedBorderPainter({required this.color, required this.containerWidth})
      : dashWidth = 2.5, // Initial width of the dashes
        dashSpace = 5; // Initial space between the dashes

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1 // Adjust the thickness of the dashed line here
      ..style = PaintingStyle.stroke;

    final double startY = size.height - 1; // The starting Y-coordinate for the bottom border
    final double startX = 0;
    final double endX = size.width;

    // Calculate the number of dashes that can fit within the container width
    final double denominator = dashWidth + dashSpace;
    final int numberOfDashes = denominator != 0 ? ((endX - startX) / (dashWidth + dashSpace)).floor() : 0;
    final double totalDashWidth = numberOfDashes * dashWidth;
    final double totalSpaceWidth = (numberOfDashes - 1) * dashSpace;
    final double totalWidth = totalDashWidth + totalSpaceWidth;

    if (numberOfDashes <= 0) {
      return; // Exit the paint function if there are no dashes to draw
    }

    // Calculate the adjusted dashWidth and dashSpace
    if (totalWidth < containerWidth) {
      final double remainingWidth = containerWidth - totalWidth;
      dashSpace += remainingWidth / (numberOfDashes - 1);
    } else if (totalWidth > containerWidth) {
      final double remainingWidth = totalWidth - containerWidth;
      dashSpace -= remainingWidth / (numberOfDashes - 1);
    }

    double currentX = startX;
    for (int i = 0; i < numberOfDashes; i++) {
      canvas.drawLine(
        Offset(currentX, startY),
        Offset(currentX + dashWidth, startY),
        paint,
      );
      currentX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}