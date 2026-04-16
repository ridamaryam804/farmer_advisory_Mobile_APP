// tools_info_screen.dart
import 'package:flutter/material.dart';
import 'crops_tools_screen.dart';
import 'hand_tools_screen.dart';
import 'machinery_screen.dart';
import 'livestock_tools_screen.dart';

class ToolsInfoScreen extends StatefulWidget {
  const ToolsInfoScreen({super.key});

  @override
  State<ToolsInfoScreen> createState() => _ToolsInfoScreenState();
}

class _ToolsInfoScreenState extends State<ToolsInfoScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<Color?> _borderGlowAnimation;

  // For individual card animations
  List<bool> _cardVisible = [false, false, false, false];
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
    for (int i = 0; i < 4; i++) {
      _cardSlideAnimations.add(
        Tween<Offset>(
          begin: _getCardStartOffset(i),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: _controller,
          curve: Interval(i * 0.15, 1.0, curve: Curves.elasticOut),
        )),
      );
    }

    // Start animations
    _controller.forward();

    // Start card entrance animations with delay
    _animateCardsSequentially();
  }

  Offset _getCardStartOffset(int index) {
    switch (index) {
      case 0: return Offset(-1.0, 0.0); // Left
      case 1: return Offset(1.0, 0.0);  // Right
      case 2: return Offset(0.0, 1.0);  // Bottom
      case 3: return Offset(0.0, -1.0); // Top
      default: return Offset(1.0, 0.0);
    }
  }

  void _animateCardsSequentially() async {
    for (int i = 0; i < _cardVisible.length; i++) {
      await Future.delayed(Duration(milliseconds: 200));
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
            image: AssetImage("assets/images/tools bgimg.png"),
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
                  // Top Banner with Back Arrow inside
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
                          // Back Arrow inside the box
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
                              'اوزار منتخب کریں',
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
                          // Empty space to balance the layout
                          SizedBox(width: 58),
                        ],
                      ),
                    ),
                  ),


                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Center(
                        child: GridView.count(
                          crossAxisCount: 2,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                          childAspectRatio: 0.9,
                          shrinkWrap: true,
                          children: [
                            _buildAnimatedToolCard(
                              'کاشتکاری کے اوزار',
                              'assets/images/crop tools.png',
                              Color(0xFF79CBFE),
                              0,
                            ),
                            _buildAnimatedToolCard(
                              'ہاتھ والے اوزار',
                              'assets/images/hand tools.png',
                              Color(0xFF18ACC0),
                              1,
                            ),
                            _buildAnimatedToolCard(
                              'مشینری',
                              'assets/images/mactool.png',
                              Color(0xFF18ACC0),
                              2,
                            ),
                            _buildAnimatedToolCard(
                              'ڈیری کے اوزار',
                              'assets/images/animals tools.png',
                              Color(0xFF79CBFE),
                              3,
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

  Widget _buildAnimatedToolCard(String title, String imagePath, Color backgroundColor, int index) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return SlideTransition(
          position: _cardSlideAnimations[index],
          child: AnimatedOpacity(
            opacity: _cardVisible[index] ? 1.0 : 0.0,
            duration: Duration(milliseconds: 500),
            child: _buildToolCard(title, imagePath, backgroundColor, index),
          ),
        );
      },
    );
  }

  Widget _buildToolCard(String title, String imagePath, Color backgroundColor, int index) {
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
            _handleToolCategoryTap(title);
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: _borderGlowAnimation.value ?? Color(0xFFF2C112),
                      width: 2,
                    ),
                    boxShadow: [
                      if (_borderGlowAnimation.value != null)
                        BoxShadow(
                          color: _borderGlowAnimation.value!.withOpacity(0.3),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.build,
                          color: backgroundColor,
                          size: 50,
                        );
                      },
                    ),
                  ),
                ),

                SizedBox(height: 12),

                // Text with subtle animation
                AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  transform: Matrix4.translationValues(
                    0,
                    _cardVisible[index] ? 0 : 10,
                    0,
                  ),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.2,
                      shadows: [
                        Shadow(
                          blurRadius: 5,
                          color: Colors.black,
                          offset: Offset(1, 1),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleToolCategoryTap(String category) {

    _controller.forward(from: 0.7);

    switch (category) {
      case 'کاشتکاری کے اوزار':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CropsToolsScreen()),
        );
        break;
      case 'ہاتھ والے اوزار':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HandToolsScreen()),
        );
        break;
      case 'مشینری':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MachineryScreen()),
        );
        break;
      case 'ڈیری کے اوزار':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LivestockToolsScreen()),
        );
        break;
    }
  }
}