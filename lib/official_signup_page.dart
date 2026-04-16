import 'package:flutter/material.dart';
import 'official_login_page.dart';
import 'dashboard_screen.dart';

class OfficialSignupPage extends StatefulWidget {
  const OfficialSignupPage({super.key});

  @override
  State<OfficialSignupPage> createState() => _OfficialSignupPageState();
}

class _OfficialSignupPageState extends State<OfficialSignupPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController serviceIdController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final String correctServiceId = "P156890QT";
  final String correctEmail = "abcde@gmail.com";

  String? serviceIdError;
  String? emailError;
  bool _obscureServiceId = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF64B5F6),
              Color(0xFF81C784),
            ],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const SizedBox(height: 50),

                    Center(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 40),
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xFF1565C0),
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFF1565C0).withOpacity(0.6),
                              blurRadius: 20,
                              spreadRadius: 3,
                              offset: Offset(0, 0),
                            ),
                            BoxShadow(
                              color: Colors.blueAccent.withOpacity(0.4),
                              blurRadius: 15,
                              spreadRadius: 1,
                              offset: Offset(0, 0),
                            ),
                          ],
                        ),
                        child: Text(
                          "Official Signup / افسر سائن اپ",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),

                    // Name Field
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: _buildTextField("Full Name / مکمل نام", "Enter your full name", nameController, isPassword: false),
                    ),

                    const SizedBox(height: 10),

                    // Service ID Field
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildTextField("Service ID / سروس آئی ڈی", "Enter service ID", serviceIdController, isPassword: true),

                          if (serviceIdError != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text(
                                serviceIdError!,
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Email Field
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildTextField("Email / ای میل", "Enter email", emailController, isPassword: false),

                          if (emailError != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text(
                                emailError!,
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Signup Button
                    Center(
                      child: Container(
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFF1B5E20).withOpacity(0.6),
                              blurRadius: 15,
                              spreadRadius: 2,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF1B5E20),
                            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            _validateAndSignup();
                          },
                          child: const Text(
                            "Signup / سائن اپ",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 50),
                  ],
                ),
              ),


              Positioned(
                top: 0,
                left: 10,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String hint, TextEditingController controller, {bool isPassword = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 50,
          child: TextField(
            controller: controller,
            obscureText: isPassword ? _obscureServiceId : false,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white.withOpacity(0.9),
              hintText: hint,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Color(0xFF1B5E20),
                  width: 2.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Color(0xFF1B5E20),
                  width: 2.0,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              suffixIcon: isPassword ? IconButton(
                icon: Icon(
                  _obscureServiceId ? Icons.visibility_off : Icons.visibility,
                  color: Color(0xFF1B5E20),
                ),
                onPressed: () {
                  setState(() {
                    _obscureServiceId = !_obscureServiceId;
                  });
                },
              ) : null,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 4),
          height: 8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Color(0xFF1B5E20).withOpacity(0.4),
                blurRadius: 8,
                spreadRadius: 1,
                offset: Offset(0, 0),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _validateAndSignup() {
    final enteredServiceId = serviceIdController.text.trim();
    final enteredEmail = emailController.text.trim();
    final enteredName = nameController.text.trim();


    setState(() {
      serviceIdError = null;
      emailError = null;
    });


    if (enteredName.isEmpty || enteredServiceId.isEmpty || enteredEmail.isEmpty) {
      setState(() {
        if (enteredServiceId.isEmpty) {
          serviceIdError = "Please enter Service ID";
        }
        if (enteredEmail.isEmpty) {
          emailError = "Please enter Email";
        }
      });
      return;
    }

    // Check if Service ID is correct
    if (enteredServiceId != correctServiceId) {
      setState(() {
        serviceIdError = "Incorrect Service ID";
      });
    }

    // Check if Email is correct
    if (enteredEmail != correctEmail) {
      setState(() {
        emailError = "Incorrect Email";
      });
    }

    // If both are correct, show success
    if (enteredServiceId == correctServiceId && enteredEmail == correctEmail) {
      _showSuccessDialog();
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.of(context).pop();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const OfficialLoginPage()),
          );
        });

        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF64B5F6),
                  Color(0xFF81C784),
                ],
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.check_circle,
                  size: 60,
                  color: Colors.white,
                ),
                const SizedBox(height: 20),
                Text(
                  'Signup Successful!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Moving to Official Login...',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Color(0xFF1B5E20),
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const OfficialLoginPage()),
                    );
                  },
                  child: const Text(
                    'OK',
                    style: TextStyle(
                      fontSize: 16,
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