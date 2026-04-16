import 'package:flutter/material.dart';

class AlertsScreen extends StatefulWidget {
  const AlertsScreen({super.key});

  @override
  State<AlertsScreen> createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
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
            image: DecorationImage(
              image: AssetImage("assets/images/backgroundimg.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              // Header
              Container(
                height: 70,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFF64B5F6),
                  border: Border.all(
                    color: Color(0xFF0D47A1),
                    width: 4,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                ),
                child: Stack(
                  children: [
                    // Back Button
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.only(left: 8),
                        child: IconButton(
                          icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),

                    // Text and Icon
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: EdgeInsets.only(left: 60, bottom: 8), // Adjusted left padding
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [

                            Text(
                              'تازہ ترین معلومات',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 8), // Small spacing between text and icon
                            // Icon
                            ShaderMask(
                              shaderCallback: (Rect bounds) {
                                return LinearGradient(
                                  colors: [
                                    Colors.white,
                                    Colors.blue.shade100,
                                    Colors.white,
                                  ],
                                  stops: [0.0, 0.5, 1.0],
                                  tileMode: TileMode.mirror,
                                ).createShader(bounds);
                              },
                              child: Image.asset(
                                "assets/images/alerts.png",
                                width: 75,
                                height: 75,
                                errorBuilder: (context, error, stackTrace) {
                                  return Icon(Icons.notifications, color: Colors.white, size: 68);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 40), // PROPER SPACING

              // List with Animation
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: ListView(
                    children: [
                      AnimatedAlertCard(
                        animation: _animation,
                        delay: 0,
                        timeLabel: 'NOW',
                        title: 'اگلے دو دن میں تیز بارش کا امکان',
                        isNew: true,
                      ),
                      SizedBox(height: 20),

                      AnimatedAlertCard(
                        animation: _animation,
                        delay: 200,
                        timeLabel: 'Yesterday',
                        title: 'فصلوں پر کیڑوں کا حملہ',
                        isNew: false,
                      ),
                      SizedBox(height: 20),

                      AnimatedAlertCard(
                        animation: _animation,
                        delay: 400,
                        timeLabel: '2 days ago',
                        title: 'آپ کے علاقے میں سیلاب متوقع ہے',
                        isNew: false,
                      ),
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

// Animated Alert Card Widget
class AnimatedAlertCard extends StatelessWidget {
  final Animation<double> animation;
  final int delay;
  final String timeLabel;
  final String title;
  final bool isNew;

  const AnimatedAlertCard({
    super.key,
    required this.animation,
    required this.delay,
    required this.timeLabel,
    required this.title,
    required this.isNew,
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
              width: double.infinity,
              height: 130,
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
                ],
              ),
              child: Stack(
                children: [
                  // TIME LABEL
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Color(0xFF1565C0),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        timeLabel,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  // BELL ICON
                  Positioned(
                    top: 40,
                    right: 8,
                    child: Image.asset(
                      "assets/images/bell.png",
                      width: 60,
                      height: 60,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.notifications,
                          color: Color(0xFF1565C0),
                          size: 56,
                        );
                      },
                    ),
                  ),


                  if (isNew)
                    Positioned(
                      top: 20,
                      right: 8,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          'NEW',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),


                  Positioned(
                    top: 0,
                    left: 0,
                    right: 5,
                    bottom: 0,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 65, left: 16),
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            height: 1.3,
                          ),
                          textAlign: TextAlign.right,
                          maxLines: 2,
                          overflow: TextOverflow.visible,
                        ),
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