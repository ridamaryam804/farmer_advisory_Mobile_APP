import 'package:flutter/material.dart';
import 'cow_detail_screen.dart';
import 'sheep_detail_screen.dart';
import 'goat_detail_screen.dart';
import 'hen_detail_screen.dart';
import 'horse_donkey_detail_screen.dart';
import 'camel_detail_screen.dart';

class AnimalsScreen extends StatefulWidget {
  const AnimalsScreen({super.key});

  @override
  State<AnimalsScreen> createState() => _AnimalsScreenState();
}

class _AnimalsScreenState extends State<AnimalsScreen> with SingleTickerProviderStateMixin {
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
                          'جانور منتخب کریں',
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

              // Animals List with Animation
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    children: [
                      // Cow - Clickable
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CowDetailScreen()),
                          );
                        },
                        child: AnimatedAnimalRow(
                          animation: _animation,
                          delay: 0,
                          urduName: 'گائے',
                          imagePath: 'assets/images/COWW.png',
                        ),
                      ),
                      SizedBox(height: 10),
                      // Sheep - Clickable
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SheepDetailScreen()),
                          );
                        },
                        child: AnimatedAnimalRow(
                          animation: _animation,
                          delay: 100,
                          urduName: 'بھیڑ',
                          imagePath: 'assets/images/sheep.png',
                        ),
                      ),
                      SizedBox(height: 10),
                      // Goat - Clickable
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => GoatDetailScreen()),
                          );
                        },
                        child: AnimatedAnimalRow(
                          animation: _animation,
                          delay: 200,
                          urduName: 'بکری',
                          imagePath: 'assets/images/goat.png',
                        ),
                      ),
                      SizedBox(height: 10),
                      // Hen - Clickable
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HenDetailScreen()),
                          );
                        },
                        child: AnimatedAnimalRow(
                          animation: _animation,
                          delay: 300,
                          urduName: 'مرغی',
                          imagePath: 'assets/images/hen.png',
                        ),
                      ),
                      SizedBox(height: 10),
                      // Horse/Donkey - Clickable
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HorseDonkeyDetailScreen()),
                          );
                        },
                        child: AnimatedHorseDonkeyRow(
                          animation: _animation,
                          delay: 400,
                        ),
                      ),
                      SizedBox(height: 10),
                      // Camel - Clickable
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CamelDetailScreen()),
                          );
                        },
                        child: AnimatedAnimalRow(
                          animation: _animation,
                          delay: 500,
                          urduName: 'اونٹ',
                          imagePath: 'assets/images/camel-removebg-preview.png',
                        ),
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

// Animated Animal Row Widget
class AnimatedAnimalRow extends StatelessWidget {
  final Animation<double> animation;
  final int delay;
  final String urduName;
  final String imagePath;

  const AnimatedAnimalRow({
    super.key,
    required this.animation,
    required this.delay,
    required this.urduName,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    bool isSheep = urduName == 'بھیڑ';

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
                    width: isSheep ? 100 : 90,
                    height: isSheep ? 100 : 90,
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
                        fit: isSheep ? BoxFit.cover : BoxFit.contain,
                        width: isSheep ? 100 : 75,
                        height: isSheep ? 100 : 75,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Color(0xFF1565C0).withOpacity(0.1),
                            child: Icon(
                              Icons.pets,
                              color: Color(0xFF1565C0),
                              size: isSheep ? 55 : 50,
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  // Urdu Text - WHITE COLOR
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

// Animated Horse Donkey Row Widget
class AnimatedHorseDonkeyRow extends StatelessWidget {
  final Animation<double> animation;
  final int delay;

  const AnimatedHorseDonkeyRow({
    super.key,
    required this.animation,
    required this.delay,
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
                    child: Stack(
                      children: [

                        Positioned(
                          left: 5,
                          top: 15,
                          child: Container(
                            width: 48,
                            height: 48,
                            child: Image.asset(
                              'assets/images/horse.png',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(
                                  Icons.pets,
                                  color: Color(0xFF1565C0),
                                  size: 32,
                                );
                              },
                            ),
                          ),
                        ),

                        Positioned(
                          right: 5,
                          bottom: 15,
                          child: Container(
                            width: 48,
                            height: 48,
                            child: Image.asset(
                              'assets/images/khota.png',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(
                                  Icons.pets,
                                  color: Color(0xFF1565C0),
                                  size: 32,
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),


                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(right: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'گھوڑا/گدھا',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
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
      },
    );
  }
}