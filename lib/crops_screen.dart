import 'package:flutter/material.dart';

class CropsScreen extends StatefulWidget {
  const CropsScreen({super.key});

  @override
  State<CropsScreen> createState() => _CropsScreenState();
}

class _CropsScreenState extends State<CropsScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF42A5F5),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF64B5F6),
                Color(0xFF66BB6A),
              ],
            ),
          ),
          child: Column(
            children: [
              // Header with back button
              Container(
                height: 70,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFF64B5F6),
                  border: Border.all(
                    color: Color(0xFF1565C0),
                    width: 3,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF1565C0).withOpacity(0.4),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white, size: 28),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          'فصل منتخب کریں',
                          
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 48),
                  ],
                ),
              ),

              SizedBox(height: 10),

              // Crops List with Animation
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    children: [
                      AnimatedCropRow(
                        animation: _animation,
                        delay: 0,
                        urduName: 'چاول',
                        imagePath: 'assets/images/rice.png',
                      ),
                      SizedBox(height: 10),
                      AnimatedCropRow(
                        animation: _animation,
                        delay: 100,
                        urduName: 'کپاس',
                        imagePath: 'assets/images/kapaas.png',
                      ),
                      SizedBox(height: 10),
                      AnimatedCropRow(
                        animation: _animation,
                        delay: 200,
                        urduName: 'گندم',
                        imagePath: 'assets/images/gandum.png',
                      ),
                      SizedBox(height: 10),
                      AnimatedCropRow(
                        animation: _animation,
                        delay: 300,
                        urduName: 'مکئی',
                        imagePath: 'assets/images/corn.png',
                      ),
                      SizedBox(height: 10),
                      AnimatedCropRow(
                        animation: _animation,
                        delay: 400,
                        urduName: 'دالیں',
                        imagePath: 'assets/images/dalay.png',
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Animated Crop Row Widget
class AnimatedCropRow extends StatelessWidget {
  final Animation<double> animation;
  final int delay;
  final String urduName;
  final String imagePath;

  const AnimatedCropRow({
    super.key,
    required this.animation,
    required this.delay,
    required this.urduName,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
            (1.0 - Curves.easeOut.transform(animation.value)) * 500,
            0,
          ),
          child: Opacity(
            opacity: animation.value,
            child: Container(
              height: 115,
              margin: EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                color: Color(0xFF87CEEB),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Color(0xFF1565C0),
                  width: 3,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF1565C0).withOpacity(0.6),
                    blurRadius: 15,
                    spreadRadius: 2,
                    offset: Offset(0, 0),
                  ),
                  BoxShadow(
                    color: Colors.blueAccent.withOpacity(0.4),
                    blurRadius: 10,
                    spreadRadius: 1,
                    offset: Offset(0, 0),
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Circular Image Container
                  Container(
                    width: 90,
                    height: 90,
                    margin: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Color(0xFF1565C0),
                        width: 3,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF1565C0).withOpacity(0.5),
                          blurRadius: 10,
                          spreadRadius: 1,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        imagePath,
                        fit: BoxFit.cover,
                        width: 75,
                        height: 75,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Color(0xFF1565C0).withOpacity(0.1),
                            child: Icon(
                              Icons.agriculture,
                              color: Color(0xFF1565C0),
                              size: 50,
                            ),
                          );
                        },
                      ),
                    ),
                  ),


                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(right: 30),
                      child: Text(
                        urduName,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}