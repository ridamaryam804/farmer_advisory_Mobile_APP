import 'package:flutter/material.dart';

class CamelDetailScreen extends StatelessWidget {
  const CamelDetailScreen({super.key});

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

              Container(
                height: 70,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFF64B5F6),
                  border: Border.all(
                    color: Color(0xFFF2C112),
                    width: 3,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFF2C112).withOpacity(0.4),
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
                          'اونٹ کی معلومات',
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

              SizedBox(height: 20),

              // Main Content
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [

                      Container(
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: Color(0xFFF2C112),
                            width: 4,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFFF2C112).withOpacity(0.6),
                              blurRadius: 15,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            'assets/images/cartoon-camel-sitting-desert-scene_1308-161236.avif',
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Color(0xFFF2C112).withOpacity(0.1),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.pets,
                                        color: Color(0xFFF2C112),
                                        size: 60,
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'تصویر لوڈ نہیں ہو سکی',
                                        style: TextStyle(
                                          color: Color(0xFFF2C112),
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),

                      SizedBox(height: 30),

                      // Information Container
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(0xFF79CBFE),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Color(0xFFF2C112),
                              width: 3,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFFF2C112).withOpacity(0.6),
                                blurRadius: 15,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: SingleChildScrollView(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'اونٹ کی اہم بیماریاں',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFF2C112),
                                  ),
                                  textAlign: TextAlign.right,
                                ),

                                SizedBox(height: 15),

                                // Coming Soon message for diseases
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: Color(0xFFF2C112), width: 2),
                                  ),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.medical_services,
                                        color: Color(0xFFF2C112),
                                        size: 40,
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'جلد آرہا ہے',
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFFF2C112),
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        'بیماریوں کی تفصیلی معلومات جلد دستیاب ہوں گی',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(height: 20),

                                Text(
                                  'حل اور احتیاطی تدابیر',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFF2C112),
                                  ),
                                  textAlign: TextAlign.right,
                                ),

                                SizedBox(height: 15),


                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: Color(0xFFF2C112), width: 2),
                                  ),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.health_and_safety,
                                        color: Color(0xFFF2C112),
                                        size: 40,
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'جلد آرہا ہے',
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFFF2C112),
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        'حل اور احتیاطی تدابیر جلد دستیاب ہوں گی',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 20),
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