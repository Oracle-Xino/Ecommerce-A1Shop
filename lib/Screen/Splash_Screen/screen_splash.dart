import 'package:a1shop/Screen/Display&Product/screen_home.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _waveController;
  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 8),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _waveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          _GradientBackground(),
          AnimatedBuilder(
            animation: _waveController,
            builder: (context, child) => CustomPaint(
              painter: _WavePaint(progress: _waveController.value),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                ),
                child: Text(
                  'Get Started',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

//Gradient background
class _GradientBackground extends StatelessWidget {
  const _GradientBackground();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: AlignmentGeometry.topLeft,
          end: AlignmentGeometry.bottomRight,
          colors: [Color(0xFF1A0B2E), Color(0xFF3E1A78), Color(0xFF7B2CBF)],
        ),
      ),
    );
  }
}

//Wave Paint
class _WavePaint extends CustomPainter {
  _WavePaint({required this.progress});

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint1 = Paint()
      ..color = Colors.white.withValues(alpha: .06)
      ..style = PaintingStyle.fill;
    final Paint paint2 = Paint()
      ..color = Colors.white.withValues(alpha: 0.4)
      ..style = PaintingStyle.fill;

    final path1 = Path();
    final path2 = Path();

    final double amplitude1 = size.height * 0.06;
    final double amplitude2 = size.height * 0.04;

    final double yBase1 = size.height * 0.72;
    final double yBase2 = size.height * 0.78;

    path1.moveTo(0, yBase1);
    path2.moveTo(0, yBase2);

    for (double x = 0; x <= size.width; x += 2) {
      final double t = (x / size.width) * 2 * math.pi;
      final double y1 =
          yBase1 + math.sin(t + progress * 2 * math.pi) * amplitude1;
      final double y2 =
          yBase2 + math.sin(t * 1.5 + progress * 2 * math.pi) * amplitude2;

      path1.lineTo(x, y1);
      path2.lineTo(x, y2);
    }

    path1
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    path2
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path1, paint1);
    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(covariant _WavePaint oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
