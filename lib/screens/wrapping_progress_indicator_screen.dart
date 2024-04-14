import 'dart:ui';

import 'package:flutter/material.dart';

class WrappingProgressIndicatorScreen extends StatefulWidget {
  const WrappingProgressIndicatorScreen({super.key});

  @override
  State<WrappingProgressIndicatorScreen> createState() => _WrappingProgressIndicatorScreenState();
}

class _WrappingProgressIndicatorScreenState extends State<WrappingProgressIndicatorScreen> {
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wrapping Progress Indicator'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Slide this",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          Slider(
            value: progress,
            onChanged: (v) {
              setState(() {
                progress = v;
              });
            },
            divisions: 100,
          ),
          const SizedBox(height: 100),
          Center(
            child: ProgressCard(
              progress: progress,
              width: 100,
              height: 200,
              borderRadius: 5,
              child: Container(
                color: Colors.pinkAccent.shade100,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProgressCard extends StatelessWidget {
  const ProgressCard({super.key, required this.progress, this.child, required this.width, required this.height, required this.borderRadius});

  final double progress;
  final Widget? child;
  final double width, height;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: width + 10,
          height: height + 10,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius > 10 ? borderRadius - 10 : 0),
          ),
          child: child ?? const SizedBox.shrink(),
        ),
        CustomPaint(
          size: Size(width + 20, height + 20),
          painter: CurvedProgressBorderPainter(
            progress: progress,
            borderRadius: borderRadius,
          ),
        ),
      ],
    );
  }
}

class CurvedProgressBorderPainter extends CustomPainter {
  CurvedProgressBorderPainter({required this.progress, this.borderRadius = 10});

  double progress;
  double borderRadius;

  @override
  void paint(Canvas canvas, Size size) {
    double x = size.width;
    double y = size.height;

    Paint paint = Paint()
      ..color = Colors.purple
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;

    Path path = Path()
      ..moveTo(x/2, 0)
      ..lineTo(x - borderRadius, 0)
      ..quadraticBezierTo(x, 0, x, borderRadius)
      ..lineTo(x, y - borderRadius)
      ..quadraticBezierTo(x, y, x - borderRadius, y)
      ..lineTo(borderRadius, y)
      ..quadraticBezierTo(0, y, 0, y - borderRadius)
      ..lineTo(0, borderRadius)
      ..quadraticBezierTo(0, 0, borderRadius, 0)
      ..lineTo(x/2, 0);

    PathMetric pathMetric = path.computeMetrics().first;
    Path extractPath = pathMetric.extractPath(0, pathMetric.length * (progress));
    canvas.drawPath(extractPath, paint);
  }

  @override
  bool shouldRepaint(covariant CurvedProgressBorderPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
