// livestock_tools_screen.dart
import 'package:flutter/material.dart';

class LivestockToolsScreen extends StatefulWidget {
  const LivestockToolsScreen({super.key});

  @override
  State<LivestockToolsScreen> createState() => _LivestockToolsScreenState();
}

class _LivestockToolsScreenState extends State<LivestockToolsScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<Color?> _borderGlowAnimation;

  // For individual card animations
  List<bool> _cardVisible = List.generate(10, (index) => false);
  List<Animation<Offset>> _cardSlideAnimations = [];

  @override
  void initState() {
    super.initState();

    // Main animation controller
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    );

    // Scale animation for entrance
    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    ));

    // Opacity animation
    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));

    // Border glow animation
    _borderGlowAnimation = ColorTween(
      begin: Color(0xFFF2C112).withOpacity(0.3),
      end: Color(0xFFF2C112).withOpacity(1.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    // Create slide animations for each card
    for (int i = 0; i < 10; i++) {
      _cardSlideAnimations.add(
        Tween<Offset>(
          begin: _getCardStartOffset(i),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: _controller,
          curve: Interval(i * 0.08, 1.0, curve: Curves.elasticOut),
        )),
      );
    }

    // Start animations
    _controller.forward();

    // Start card entrance animations with delay
    _animateCardsSequentially();
  }

  Offset _getCardStartOffset(int index) {
    List<Offset> startOffsets = [
      Offset(-1.0, 0.0), // Left
      Offset(1.0, 0.0),  // Right
      Offset(0.0, 1.0),  // Bottom
      Offset(0.0, -1.0), // Top
      Offset(-1.0, -1.0), // Top Left
      Offset(1.0, -1.0),  // Top Right
      Offset(-1.0, 1.0),  // Bottom Left
      Offset(1.0, 1.0),   // Bottom Right
      Offset(-0.5, 1.0),  // Bottom Left slight
      Offset(0.5, -1.0),  // Top Right slight
    ];
    return startOffsets[index % startOffsets.length];
  }

  void _animateCardsSequentially() async {
    for (int i = 0; i < _cardVisible.length; i++) {
      await Future.delayed(Duration(milliseconds: 150));
      if (mounted) {
        setState(() {
          _cardVisible[i] = true;
        });
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/crops bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: FadeTransition(
              opacity: _opacityAnimation,
              child: Column(
                children: [

                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 10),
                      decoration: BoxDecoration(
                        color: Color(0xFF18ACC0),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Color(0xFFF2C112),
                          width: 3,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [

                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                          SizedBox(width: 10),
                          // Text
                          Expanded(
                            child: Text(
                              'ڈیری کے اوزار',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    blurRadius: 5,
                                    color: Colors.black,
                                    offset: Offset(2, 2),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(width: 58),
                        ],
                      ),
                    ),
                  ),

                  // Main Content
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Center(
                        child: GridView.count(
                          crossAxisCount: 2,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                          childAspectRatio: 0.85,
                          shrinkWrap: true,
                          children: [
                            _buildAnimatedToolCard(
                              'assets/images/31.png',
                              Color(0xFF79CBFE),
                              0,
                            ),
                            _buildAnimatedToolCard(
                              'assets/images/32.png',
                              Color(0xFF18ACC0),
                              1,
                            ),
                            _buildAnimatedToolCard(
                              'assets/images/33.png',
                              Color(0xFF79CBFE),
                              2,
                            ),
                            _buildAnimatedToolCard(
                              'assets/images/34.png',
                              Color(0xFF18ACC0),
                              3,
                            ),
                            _buildAnimatedToolCard(
                              'assets/images/35.png',
                              Color(0xFF79CBFE),
                              4,
                            ),
                            _buildAnimatedToolCard(
                              'assets/images/36.png',
                              Color(0xFF18ACC0),
                              5,
                            ),
                            _buildAnimatedToolCard(
                              'assets/images/37.png',
                              Color(0xFF79CBFE),
                              6,
                            ),
                            _buildAnimatedToolCard(
                              'assets/images/38.png',
                              Color(0xFF18ACC0),
                              7,
                            ),
                            _buildAnimatedToolCard(
                              'assets/images/39.png',
                              Color(0xFF79CBFE),
                              8,
                            ),
                            _buildAnimatedToolCard(
                              'assets/images/40.png',
                              Color(0xFF18ACC0),
                              9,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Bottom spacing
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedToolCard(String imagePath, Color backgroundColor, int index) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return SlideTransition(
          position: _cardSlideAnimations[index],
          child: AnimatedOpacity(
            opacity: _cardVisible[index] ? 1.0 : 0.0,
            duration: Duration(milliseconds: 500),
            child: _buildToolCard(imagePath, backgroundColor, index),
          ),
        );
      },
    );
  }

  Widget _buildToolCard(String imagePath, Color backgroundColor, int index) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: _borderGlowAnimation.value ?? Color(0xFFF2C112),
          width: 3,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
          if (_borderGlowAnimation.value != null)
            BoxShadow(
              color: _borderGlowAnimation.value!.withOpacity(0.5),
              blurRadius: 15,
              spreadRadius: 2,
            ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            _showCustomMessage(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.build,
                    color: Colors.white,
                    size: 50,
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showCustomMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Color(0xFFF2C112),
                width: 3,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.info_outline,
                  color: Color(0xFF18ACC0),
                  size: 50,
                ),
                SizedBox(height: 16),
                Text(
                  'آپ کو جلد ہی مکمل معلومات دی جائیں گی۔\nانتظار کا شکریہ!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF18ACC0),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF18ACC0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  ),
                  child: Text(
                    'ٹھیک ہے',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}