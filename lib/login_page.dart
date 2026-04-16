import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'chat_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode usernameFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  late AnimationController _titleController;
  late AnimationController _buttonController;
  late AnimationController _colorController;
  late AnimationController _fieldController;
  late Animation<double> _titleAnimation;
  late Animation<double> _buttonAnimation;
  late Animation<double> _fieldAnimation;
  late Animation<Color?> _colorAnimation;

  // Butterfly Animations
  late List<AnimationController> _butterflyControllers;
  late List<Animation<Offset>> _butterflyAnimations;
  late List<Animation<double>> _butterflyFlapAnimations;
  final int _butterflyCount = 8;

  final String fixedUsername = "Rida";
  final String fixedPassword = "qaidino804";

  String? usernameError;
  String? passwordError;

  @override
  void initState() {
    super.initState();

    _titleController = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _titleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _titleController,
      curve: Curves.easeInOut,
    ));

    _colorController = AnimationController(
      duration: Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);

    _colorAnimation = ColorTween(
      begin: Colors.green,
      end: Colors.purple,
    ).animate(CurvedAnimation(
      parent: _colorController,
      curve: Curves.easeInOut,
    ));

    _fieldController = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );

    _fieldAnimation = Tween<double>(
      begin: 1.0,
      end: 1.03,
    ).animate(CurvedAnimation(
      parent: _fieldController,
      curve: Curves.easeInOut,
    ));

    _buttonController = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _buttonAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _buttonController,
      curve: Curves.easeInOut,
    ));

    _initializeButterflyAnimations();
  }

  void _initializeButterflyAnimations() {
    _butterflyControllers = [];
    _butterflyAnimations = [];
    _butterflyFlapAnimations = [];

    for (int i = 0; i < _butterflyCount; i++) {
      final controller = AnimationController(
        duration: Duration(milliseconds: 3000 + (i * 1000)),
        vsync: this,
      )..repeat(reverse: true);

      final flapController = AnimationController(
        duration: Duration(milliseconds: 200 + (i * 100)),
        vsync: this,
      )..repeat(reverse: true);

      final animation = Tween<Offset>(
        begin: _getButterflyStartPosition(i),
        end: _getButterflyEndPosition(i),
      ).animate(CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      ));

      final flapAnimation = Tween<double>(
        begin: 0.0,
        end: 0.3,
      ).animate(CurvedAnimation(
        parent: flapController,
        curve: Curves.easeInOut,
      ));

      _butterflyControllers.add(controller);
      _butterflyAnimations.add(animation);
      _butterflyFlapAnimations.add(flapAnimation);
    }
  }

  Offset _getButterflyStartPosition(int index) {
    switch (index % 8) {
      case 0: return Offset(-0.1, 0.1);
      case 1: return Offset(1.1, 0.2);
      case 2: return Offset(0.8, -0.1);
      case 3: return Offset(-0.1, 0.6);
      case 4: return Offset(1.1, 0.7);
      case 5: return Offset(0.3, -0.1);
      case 6: return Offset(-0.1, 0.9);
      case 7: return Offset(1.1, 0.4);
      default: return Offset(-0.1, 0.1);
    }
  }

  Offset _getButterflyEndPosition(int index) {
    switch (index % 8) {
      case 0: return Offset(1.1, 0.8);
      case 1: return Offset(-0.1, 0.5);
      case 2: return Offset(0.2, 1.1);
      case 3: return Offset(1.1, 0.3);
      case 4: return Offset(-0.1, 0.2);
      case 5: return Offset(0.9, 1.1);
      case 6: return Offset(1.1, 0.6);
      case 7: return Offset(-0.1, 0.7);
      default: return Offset(1.1, 0.8);
    }
  }

  Color _getButterflyColor(int index) {
    final colors = [
      Colors.pink[300]!,
      Colors.purple[300]!,
      Colors.blue[300]!,
      Colors.orange[300]!,
      Colors.yellow[600]!,
      Colors.green[300]!,
      Colors.red[300]!,
      Colors.deepPurple[300]!,
    ];
    return colors[index % colors.length];
  }

  Widget _buildButterfly(int index, Offset position, double flap) {
    final color = _getButterflyColor(index);
    final size = 20.0 + (index * 2.0);

    return Positioned(
      left: position.dx * MediaQuery.of(context).size.width,
      top: position.dy * MediaQuery.of(context).size.height,
      child: Transform.rotate(
        angle: flap * 2,
        child: Container(
          width: size,
          height: size,
          child: CustomPaint(
            painter: ButterflyPainter(color: color, flapAmount: flap),
          ),
        ),
      ),
    );
  }

  void _startFieldAnimation() {
    _fieldController.forward().then((_) {
      _fieldController.reverse();
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _buttonController.dispose();
    _colorController.dispose();
    _fieldController.dispose();
    usernameFocusNode.dispose();
    passwordFocusNode.dispose();
    for (final controller in _butterflyControllers) {
      controller.dispose();
    }
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }


  void validateLogin(BuildContext context) async {
    setState(() {
      usernameError = null;
      passwordError = null;
    });

    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    if (username != fixedUsername) {
      usernameError = "غلط صارف نام / Wrong Username";
    }
    if (password != fixedPassword) {
      passwordError = "غلط پاس ورڈ / Wrong Password";
    }

    if (usernameError == null && passwordError == null) {

      try {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('username', username);

        print('✅ Login data saved:');
        print('Username: $username');
        print('isLoggedIn: true');

        _showSuccessConfetti();
      } catch (e) {
        print('❌ Error saving login data: $e');

        _showSuccessConfetti();
      }
    }
  }

  void _showSuccessConfetti() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: 2), () {
          Navigator.of(context).pop();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ChatScreen(hasAccount: true),
            ),
          );
        });

        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            width: 300,
            height: 300,
            child: Stack(
              children: [
                Positioned(
                  top: 50,
                  left: 50,
                  child: Icon(Icons.celebration, size: 40, color: Colors.yellow),
                ),
                Positioned(
                  top: 80,
                  right: 60,
                  child: Icon(Icons.celebration, size: 35, color: Colors.orange),
                ),
                Positioned(
                  bottom: 70,
                  left: 70,
                  child: Icon(Icons.celebration, size: 45, color: Colors.red),
                ),
                Positioned(
                  bottom: 100,
                  right: 80,
                  child: Icon(Icons.celebration, size: 30, color: Colors.blue),
                ),
                Positioned(
                  top: 120,
                  left: 100,
                  child: Icon(Icons.celebration, size: 25, color: Colors.green),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.celebration,
                        size: 80,
                        color: Colors.yellow,
                      ),
                      SizedBox(height: 20),
                      Text(
                        '🎉 Login Successful! 🎉',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Taking you to Chat...',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF64B5F6),
                  Color(0xFF81C784),
                ],
              ),
            ),
            child: Stack(
              children: [
                // Butterflies
                ...List.generate(_butterflyCount, (index) {
                  return AnimatedBuilder(
                    animation: Listenable.merge([
                      _butterflyAnimations[index],
                      _butterflyFlapAnimations[index],
                    ]),
                    builder: (context, child) {
                      return _buildButterfly(
                        index,
                        _butterflyAnimations[index].value,
                        _butterflyFlapAnimations[index].value,
                      );
                    },
                  );
                }),

                // Main Content
                SafeArea(
                  child: Padding(
                    padding: EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),


                        Center(
                          child: ScaleTransition(
                            scale: _titleAnimation,
                            child: AnimatedBuilder(
                              animation: _colorAnimation,
                              builder: (context, child) {
                                return Text(
                                  "LOGIN / لاگ ان",
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: _colorAnimation.value,
                                    shadows: [
                                      Shadow(
                                        blurRadius: 25,
                                        color: _colorAnimation.value!.withOpacity(0.8),
                                        offset: Offset(0, 0),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Center(
                          child: Container(
                            height: 4,
                            width: 320,
                            color: Colors.purple,
                          ),
                        ),
                        SizedBox(height: 50),


                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            "Username / صارف نام",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Center(
                          child: ScaleTransition(
                            scale: _fieldAnimation,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.95),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.green.withOpacity(0.4),
                                    blurRadius: 10,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                              child: TextField(
                                controller: usernameController,
                                focusNode: usernameFocusNode,
                                decoration: InputDecoration(
                                  hintText: "Enter Username",
                                  errorText: usernameError,
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                ),
                                onTap: _startFieldAnimation,
                                onChanged: (_) {
                                  if (usernameError != null) {
                                    setState(() {
                                      usernameError = null;
                                    });
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 25),

                        // Password Section
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            "Password / پاس ورڈ",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Center(
                          child: ScaleTransition(
                            scale: _fieldAnimation,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.95),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.purple.withOpacity(0.4),
                                    blurRadius: 10,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                              child: TextField(
                                controller: passwordController,
                                focusNode: passwordFocusNode,
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: "Enter Password",
                                  errorText: passwordError,
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                ),
                                onTap: _startFieldAnimation,
                                onChanged: (_) {
                                  if (passwordError != null) {
                                    setState(() {
                                      passwordError = null;
                                    });
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 40),

                        // Login Button
                        Center(
                          child: ScaleTransition(
                            scale: _buttonAnimation,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.green.withOpacity(0.7),
                                    blurRadius: 15,
                                    offset: Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green[800],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                                  elevation: 8,
                                  shadowColor: Colors.green.withOpacity(0.6),
                                ),
                                onPressed: () => validateLogin(context),
                                child: Text(
                                  "لاگ ان کریں / Login",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
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
      ),
    );
  }
}

class ButterflyPainter extends CustomPainter {
  final Color color;
  final double flapAmount;

  ButterflyPainter({required this.color, required this.flapAmount});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);
    final wingWidth = size.width / 2;
    final wingHeight = size.height / 2 * (1 - flapAmount * 0.5);

    final leftWing = Path()
      ..moveTo(center.dx, center.dy)
      ..quadraticBezierTo(
        center.dx - wingWidth,
        center.dy - wingHeight,
        center.dx - wingWidth * 0.8,
        center.dy,
      )
      ..quadraticBezierTo(
        center.dx - wingWidth,
        center.dy + wingHeight,
        center.dx,
        center.dy,
      );

    final rightWing = Path()
      ..moveTo(center.dx, center.dy)
      ..quadraticBezierTo(
        center.dx + wingWidth,
        center.dy - wingHeight,
        center.dx + wingWidth * 0.8,
        center.dy,
      )
      ..quadraticBezierTo(
        center.dx + wingWidth,
        center.dy + wingHeight,
        center.dx,
        center.dy,
      );

    canvas.drawPath(leftWing, paint);
    canvas.drawPath(rightWing, paint);

    final bodyPaint = Paint()
      ..color = Colors.brown
      ..style = PaintingStyle.fill;

    canvas.drawOval(
      Rect.fromCenter(
        center: center,
        width: size.width / 6,
        height: size.height / 2,
      ),
      bodyPaint,
    );
  }

  @override
  bool shouldRepaint(covariant ButterflyPainter oldDelegate) {
    return color != oldDelegate.color || flapAmount != oldDelegate.flapAmount;
  }
}