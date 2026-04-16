import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_page.dart';
import 'get_started.dart';
import 'chat_screen.dart';
import 'profile_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Farmer Advisory',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: const Color(0xFFF5EFC0),
      ),
      home: const WelcomePage(),
    );
  }
}
class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/x4.webp"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Foreground Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Farmer Picture
                Image.asset(
                  "assets/images/stock-vector-poor-indian-farmer-carrying-hay-732989998-removebg-preview.png",
                  height: 200,
                ),
                const SizedBox(height: 20),


                const Text(
                  'Welcome / خوش آمدید',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 8,
                        color: Colors.black45,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),

                // Get Started Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignupPage()),
                    );
                  },
                  child: const Text(
                    'Get Started / شروعات کریں',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}
class _SignupPageState extends State<SignupPage> with TickerProviderStateMixin {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? usernameError;
  String? mobileError;
  String? passwordError;

  // Animation Controllers
  late AnimationController _titleController;
  late AnimationController _iconsController;
  late AnimationController _buttonController;
  late AnimationController _colorController;
  late Animation<double> _titleAnimation;
  late Animation<double> _buttonAnimation;
  late Animation<Color?> _colorAnimation;


  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();

    // Title Glow Animation with Multiple Colors
    _titleController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _titleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.15,
    ).animate(CurvedAnimation(
      parent: _titleController,
      curve: Curves.easeInOut,
    ));

    // Color Animation for Title - ORIGINAL COLORS
    _colorController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    )..repeat(reverse: true);

    _colorAnimation = ColorTween(
      begin: Colors.green,
      end: Colors.purple,
    ).animate(CurvedAnimation(
      parent: _colorController,
      curve: Curves.easeInOut,
    ));

    // Icons Floating Animation
    _iconsController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    // Button Glow Animation
    _buttonController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);

    _buttonAnimation = Tween<double>(
      begin: 1.0,
      end: 1.08,
    ).animate(CurvedAnimation(
      parent: _buttonController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _titleController.dispose();
    _iconsController.dispose();
    _buttonController.dispose();
    _colorController.dispose();
    usernameController.dispose();
    mobileController.dispose();
    passwordController.dispose();
    super.dispose();
  }


  void validateAndProceed() async {
    setState(() {
      usernameError = null;
      mobileError = null;
      passwordError = null;
    });

    final username = usernameController.text.trim();
    final mobile = mobileController.text.trim();
    final password = passwordController.text.trim();


    if (username.isEmpty) {
      usernameError = 'Username is required';
    }
    if (mobile.isEmpty) {
      mobileError = 'Mobile number is required';
    }
    if (password.isEmpty) {
      passwordError = 'Password is required';
    }

    if (usernameError == null && mobileError == null && passwordError == null) {

      await _saveUserData(
        username: username,
        mobile: mobile,
        password: password,
      );
      _showSuccessConfetti();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all required fields")),
      );
    }
  }


  Future<void> _saveUserData({
    required String username,
    required String mobile,
    required String password,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    await prefs.setString('mobile', mobile);
    await prefs.setString('password', password);
    await prefs.setString('joinDate', DateTime.now().toString().split(' ')[0]);
    await prefs.setBool('isLoggedIn', true);

    print('✅ User data saved:');
    print('Username: $username');
    print('Mobile: $mobile');
    print('Join Date: ${DateTime.now().toString().split(' ')[0]}');
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
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        });

        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            width: 300,
            height: 300,
            child: Stack(
              children: [
                Positioned(top: 50, left: 50, child: Icon(Icons.celebration, size: 40, color: Colors.yellow)),
                Positioned(top: 80, right: 60, child: Icon(Icons.celebration, size: 35, color: Colors.orange)),
                Positioned(bottom: 70, left: 70, child: Icon(Icons.celebration, size: 45, color: Colors.red)),
                Positioned(bottom: 100, right: 80, child: Icon(Icons.celebration, size: 30, color: Colors.blue)),
                Positioned(top: 120, left: 100, child: Icon(Icons.celebration, size: 25, color: Colors.green)),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.celebration, size: 80, color: Colors.yellow),
                      SizedBox(height: 20),
                      Text('🎉 Sign Up Successful! 🎉',
                          style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                      Text('Taking you to Login...', style: TextStyle(fontSize: 16, color: Colors.white)),
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


  InputDecoration fieldDecoration(String label, String? error, bool hasFocus, bool isPassword) {
    return InputDecoration(
      filled: true,
      fillColor: hasFocus ? Colors.green[50] : Colors.white.withOpacity(0.8),
      hintText: label.contains("Password") ? "Enter Password" : "Enter here",
      hintStyle: TextStyle(color: Colors.black54),
      errorText: error,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: Colors.green,
          width: 2.0,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 2.0,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 2.0,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),

      suffixIcon: isPassword ? IconButton(
        icon: Icon(
          _obscurePassword ? Icons.visibility_off : Icons.visibility,
          color: Colors.grey[600],
        ),
        onPressed: () {
          setState(() {
            _obscurePassword = !_obscurePassword;
          });
        },
      ) : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF87CEEB), // Light Sky Blue
              Color(0xFF98FB98), // Light Pastel Green
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),


                ScaleTransition(
                  scale: _titleAnimation,
                  child: AnimatedBuilder(
                    animation: _colorAnimation,
                    builder: (context, child) {
                      return Text(
                        "SIGN UP / سائن اپ",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: _colorAnimation.value,
                          shadows: [
                            Shadow(
                              blurRadius: 20,
                              color: _colorAnimation.value!.withOpacity(0.6),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 12),
                const Divider(thickness: 2, color: Colors.purple),
                const SizedBox(height: 12),


                buildField("Username / صارف نام", usernameController, usernameError, false),
                const SizedBox(height: 10),
                buildField("Mobile Number / موبائل نمبر", mobileController, mobileError, false),
                const SizedBox(height: 10),
                buildField("Password / پاس ورڈ", passwordController, passwordError, true),
                const SizedBox(height: 12),


                buildAnimatedIcons(),
                const SizedBox(height: 5),


                SizedBox(
                  height: 290,
                  child: Stack(
                    children: [

                      Positioned(
                        left: -55,
                        bottom: -20,
                        child: Image.asset('assets/images/x1.png', height: 280, width: 230),
                      ),
                      Positioned(
                        right: -70,
                        bottom: -20,
                        child: Image.asset('assets/images/x2.png', height: 280, width: 230),
                      ),


                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 210,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: ScaleTransition(
                            scale: _buttonAnimation,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.green.withOpacity(0.6),
                                    blurRadius: 15,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green[700],
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                                  elevation: 8,
                                  shadowColor: Colors.green.withOpacity(0.5),
                                ),
                                onPressed: validateAndProceed,
                                child: const Text(
                                  "آگے بڑھیں / Next",
                                  style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildField(String label, TextEditingController controller, String? error, bool isPassword) {
    return Focus(
      onFocusChange: (hasFocus) {
        setState(() {});
      },
      child: Builder(
        builder: (context) {
          final hasFocus = Focus.of(context).hasFocus;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(
                label,
                style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 6),
              SizedBox(
                height: 44,
                child: TextField(
                  controller: controller,
                  obscureText: isPassword ? _obscurePassword : false,
                  keyboardType: label.contains("Mobile") ? TextInputType.phone : TextInputType.text,
                  decoration: fieldDecoration(label, error, hasFocus, isPassword),
                  style: TextStyle(color: Colors.black),
                  onChanged: (_) {
                    if (error != null) {
                      setState(() {
                        if (label.contains("Username")) usernameError = null;
                        if (label.contains("Mobile")) mobileError = null;
                        if (label.contains("Password")) passwordError = null;
                      });
                    }
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildAnimatedIcons() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: LayoutBuilder(
        builder: (context, constraints) {
          double iconSize = constraints.maxWidth < 400 ? 35 : 45;
          return AnimatedBuilder(
            animation: _iconsController,
            builder: (context, child) {
              return Wrap(
                alignment: WrapAlignment.center,
                spacing: 18,
                runSpacing: 10,
                children: [
                  for (int i = 0; i < icons.length; i++)
                    Transform.translate(
                      offset: Offset(0, (i.isEven ? -1 : 1) * 10 * _iconsController.value),
                      child: buildCircleIcon(icons[i], iconSize),
                    ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  final List<String> icons = [
    'assets/images/wifi.png',
    'assets/images/temprature.png',
    'assets/images/leaf.png',
    'assets/images/growth.png',
    'assets/images/sun.png',
    'assets/images/rain.png',
    'assets/images/drop.png',
    'assets/images/tractor.png',
  ];

  Widget buildCircleIcon(String imagePath, double size) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              blurRadius: 4,
              offset: const Offset(2, 2)
          ),
        ],
      ),
      padding: const EdgeInsets.all(8),
      child: Image.asset(imagePath, height: size, width: size, fit: BoxFit.contain),
    );
  }
}