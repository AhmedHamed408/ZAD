import 'package:flutter/material.dart';
import 'dart:math';

class CustomQrWidget extends StatelessWidget {
  final String data;
  final double size;
  final Color color;
  final Color backgroundColor;

  const CustomQrWidget({
    super.key,
    required this.data,
    this.size = 220,
    this.color = const Color(0xFF0F172A),
    this.backgroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 20,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          )
        ],
        border: Border.all(
          color: Colors.grey.withValues(alpha: 0.15),
          width: 1.5,
        ),
      ),
      child: CustomPaint(
        size: Size(size - 32, size - 32),
        painter: QrCodePainter(data: data, color: color),
      ),
    );
  }
}

class QrCodePainter extends CustomPainter {
  final String data;
  final Color color;

  QrCodePainter({required this.data, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    const int matrixSize = 23;
    final double cellSize = size.width / matrixSize;

    // Deterministic random module pattern generation based on seed of `data`
    final Random random = Random(data.hashCode);

    // Draw finder patterns (top-left, top-right, bottom-left)
    _drawFinderPattern(canvas, paint, 0, 0, cellSize);
    _drawFinderPattern(canvas, paint, (matrixSize - 7) * cellSize, 0, cellSize);
    _drawFinderPattern(canvas, paint, 0, (matrixSize - 7) * cellSize, cellSize);

    // Fill data grid modules
    for (int r = 0; r < matrixSize; r++) {
      for (int c = 0; c < matrixSize; c++) {
        // Skip finder pattern zones
        if ((r < 7 && c < 7) ||
            (r < 7 && c >= matrixSize - 7) ||
            (r >= matrixSize - 7 && c < 7)) {
          continue;
        }

        // Timing patterns
        if (r == 6 || c == 6) {
          if ((r + c) % 2 == 0) {
            canvas.drawRect(
              Rect.fromLTWH(c * cellSize, r * cellSize, cellSize * 0.9, cellSize * 0.9),
              paint,
            );
          }
          continue;
        }

        // Data dots pattern
        if (random.nextBool()) {
          final rect = Rect.fromLTWH(
            c * cellSize + cellSize * 0.05,
            r * cellSize + cellSize * 0.05,
            cellSize * 0.9,
            cellSize * 0.9,
          );
          canvas.drawRRect(
            RRect.fromRectAndRadius(rect, Radius.circular(cellSize * 0.25)),
            paint,
          );
        }
      }
    }
  }

  void _drawFinderPattern(Canvas canvas, Paint paint, double x, double y, double cellSize) {
    // Outer square 7x7
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(x, y, 7 * cellSize, 7 * cellSize),
        Radius.circular(cellSize * 1.5),
      ),
      paint,
    );

    // Inner white gap 5x5
    final whitePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(x + cellSize, y + cellSize, 5 * cellSize, 5 * cellSize),
        Radius.circular(cellSize),
      ),
      whitePaint,
    );

    // Center square 3x3
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(x + 2 * cellSize, y + 2 * cellSize, 3 * cellSize, 3 * cellSize),
        Radius.circular(cellSize * 0.8),
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant QrCodePainter oldDelegate) => oldDelegate.data != data;
}
