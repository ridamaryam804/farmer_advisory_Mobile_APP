import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'dart:math' as math;
import 'main.dart';
import 'official_signup_page.dart';
import 'dashboard_screen.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  late Animation<double> _glowAnimation;

  final int _rainDropCount = 150;
  final List<double> _xPositions = [];
  final List<double> _yPositions = [];
  final List<double> _speeds = [];
  final List<double> _lengths = [];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat();

    _colorAnimation = ColorTween(
      begin: Colors.green[800],
      end: Colors.purple[800],
    ).animate(_controller);


    _glowAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    for (int i = 0; i < _rainDropCount; i++) {
      _xPositions.add(math.Random().nextDouble());
      _yPositions.add(math.Random().nextDouble() * 2 - 1);
      _speeds.add(12 + math.Random().nextDouble() * 8);
      _lengths.add(8 + math.Random().nextDouble() * 10);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startGetStartedButtonGlow() {

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const DashboardScreen()),
    );
  }

  Widget _buildRainDrop(Size size, int index) {
    double newY = _yPositions[index] + (_speeds[index] / size.height);

    if (newY > 1.0) {
      newY = -0.2;
      _xPositions[index] = math.Random().nextDouble();
    }

    _yPositions[index] = newY;

    return Positioned(
      left: _xPositions[index] * size.width,
      top: newY * size.height,
      child: Container(
        width: 1.2,
        height: _lengths[index],
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white.withOpacity(0.9),
              Colors.blue[100]!.withOpacity(0.7),
            ],
          ),
          borderRadius: BorderRadius.circular(0.5),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Stack(
            children: [

              SizedBox.expand(
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    Colors.grey[700]!.withOpacity(0.3),
                    BlendMode.darken,
                  ),
                  child: Image.asset(
                    "assets/images/x4.webp",
                    fit: BoxFit.cover,
                  ),
                ),
              ),


              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.grey[800]!.withOpacity(0.4),
                      Colors.grey[600]!.withOpacity(0.3),
                      Colors.grey[400]!.withOpacity(0.2),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),


              ...List.generate(_rainDropCount, (index) => _buildRainDrop(size, index)),


              ...List.generate(50, (index) {
                double x = math.Random().nextDouble();
                double y = (math.Random().nextDouble() * 2 - 1);
                return Positioned(
                  left: x * size.width,
                  top: y * size.height,
                  child: Container(
                    width: 0.8,
                    height: 6 + math.Random().nextDouble() * 6,
                    color: Colors.white.withOpacity(0.6),
                  ),
                );
              }),

              SafeArea(
                child: Stack(
                  children: [

                    Positioned(
                      top: 40,
                      left: 0,
                      right: 0,
                      child: Column(
                        children: [
                          AnimatedBuilder(
                            animation: _colorAnimation,
                            builder: (context, child) {
                              return Text(
                                "WELCOME / خوش آمدید",
                                style: TextStyle(
                                  fontSize: 34,
                                  fontWeight: FontWeight.bold,
                                  color: _colorAnimation.value,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 20,
                                      color: Colors.black.withOpacity(0.8),
                                      offset: const Offset(2, 2),
                                    ),
                                    Shadow(
                                      blurRadius: 30,
                                      color: Colors.white.withOpacity(0.3),
                                      offset: const Offset(-1, -1),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                              );
                            },
                          ),
                        ],
                      ),
                    ),


                    Positioned(
                      left: 60,
                      bottom: 270,
                      child: Image.asset(
                        "assets/images/stock-vector-poor-indian-farmer-carrying-hay-732989998-removebg-preview.png",
                        height: 160,
                        fit: BoxFit.contain,
                      ),
                    ),


                    Positioned(
                      bottom: 150,
                      left: 120,
                      right: 120,
                      child: ScaleTransition(
                        scale: _glowAnimation,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.green.withOpacity(0.6),
                                blurRadius: 15,
                                spreadRadius: 2,
                              ),
                              BoxShadow(
                                color: Colors.white.withOpacity(0.3),
                                blurRadius: 8,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green[700],
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              elevation: 0,
                              minimumSize: Size(120, 40),
                            ),
                            onPressed: _startGetStartedButtonGlow,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Get Started",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  "شروعات کریں",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white.withOpacity(0.9),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}