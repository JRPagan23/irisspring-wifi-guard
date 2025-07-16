import 'dart:math';
import 'package:flutter/material.dart';

class ParticleBackground extends StatefulWidget {
  const ParticleBackground({super.key});

  @override
  State<ParticleBackground> createState() => _ParticleBackgroundState();
}

class _ParticleBackgroundState extends State<ParticleBackground> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<_Particle> _particles = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 20))..repeat();
    for (int i = 0; i < 150; i++) {
      _particles.add(_Particle());
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ParticlePainter(_particles, _controller),
      child: Container(),
    );
  }
}

class _Particle {
  late double x;
  late double y;
  late double size;
  late double speed;

  _Particle() {
    final random = Random();
    x = random.nextDouble();
    y = random.nextDouble();
    size = random.nextDouble() * 2 + 0.5;
    speed = random.nextDouble() * 0.001 + 0.0005;
  }

  void move() {
    y += speed;
    if (y > 1) {
      y = 0;
    }
  }
}

class _ParticlePainter extends CustomPainter {
  final List<_Particle> particles;
  final Animation<double> animation;
  final Paint paintDot = Paint()..color = Colors.cyanAccent.withOpacity(0.7);

  _ParticlePainter(this.particles, this.animation) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    for (final particle in particles) {
      final offset = Offset(particle.x * size.width, particle.y * size.height);
      canvas.drawCircle(offset, particle.size, paintDot);
      particle.move();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

