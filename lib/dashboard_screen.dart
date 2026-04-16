import 'package:flutter/material.dart';
import 'chat_screen.dart';
import 'official_signup_page.dart';
import 'official_login_page.dart';
import 'get_started.dart';
import 'profile_screen.dart';
import 'video_screen.dart';
import 'animals_screen.dart';
import 'crops_screen.dart';
import 'alerts_screen.dart';
import 'tools_info_screen.dart';
import 'farming_tips_screen.dart';
import 'city_screen.dart';
import 'market_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatScreen(hasAccount: false),
        ),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfileScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF64B5F6),
      appBar: AppBar(
        title: Text(
          'خوشحال کسان',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xFF64B5F6),
        elevation: 0,
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.white,
              size: 28,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
      drawer: _buildDrawer(),
      body: Container(
        padding: EdgeInsets.all(16.0),
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
        child: Column(
          children: [
            // Weather Card
            _buildWeatherCard(),
            SizedBox(height: 30),

            // Main Menu Grid
            Expanded(
              child: _buildMenuGrid(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Color(0xFF81C784),
          boxShadow: [
            BoxShadow(
              color: Colors.green.withOpacity(0.4),
              blurRadius: 8,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFF81C784),
            border: Border(
              top: BorderSide(
                color: Color(0xFF1B5E20),
                width: 2,
              ),
              left: BorderSide(
                color: Color(0xFF1B5E20),
                width: 2,
              ),
              right: BorderSide(
                color: Color(0xFF1B5E20),
                width: 2,
              ),
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: _onItemTapped,
            selectedItemColor: Color(0xFF1B5E20),
            unselectedItemColor: Color(0xFF1B5E20).withOpacity(0.7),
            backgroundColor: Colors.transparent,
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            selectedLabelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            unselectedLabelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            items: [
              BottomNavigationBarItem(
                icon: Container(
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: _currentIndex == 0 ? Color(0xFF1B5E20).withOpacity(0.3) : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => WelcomePage()),
                      );
                    },
                    child: Image.asset(
                      "assets/images/home.png",
                      width: 24,
                      height: 24,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.home,
                          color: _currentIndex == 0 ? Color(0xFF1B5E20) : Color(0xFF1B5E20).withOpacity(0.7),
                          size: 24,
                        );
                      },
                    ),
                  ),
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: _currentIndex == 1 ? Color(0xFF1B5E20).withOpacity(0.3) : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    "assets/images/chat.png",
                    width: 24,
                    height: 24,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.chat,
                        color: _currentIndex == 1 ? Color(0xFF1B5E20) : Color(0xFF1B5E20).withOpacity(0.7),
                        size: 24,
                      );
                    },
                  ),
                ),
                label: 'Chat',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: _currentIndex == 2 ? Color(0xFF1B5E20).withOpacity(0.3) : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfileScreen()),
                      );
                    },
                    child: Image.asset(
                      "assets/images/profile.png",
                      width: 24,
                      height: 24,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.person,
                          color: _currentIndex == 2 ? Color(0xFF1B5E20) : Color(0xFF1B5E20).withOpacity(0.7),
                          size: 24,
                        );
                      },
                    ),
                  ),
                ),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Drawer Widget
  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: Colors.white,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF64B5F6),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Farmer App',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.verified_user, color: Color(0xFF64B5F6)),
              title: Text(
                'سرکاری افسر کی سائن اَپ',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OfficialSignupPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.video_library, color: Color(0xFF64B5F6)),
              title: Text(
                'ویڈیوز',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VideoScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.language, color: Color(0xFF64B5F6)),
              title: Text(
                'زبانیں',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              onTap: () {
                _showLanguageDialog();
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.settings, color: Color(0xFF64B5F6)),
              title: Text(
                'ترتیبات',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.help, color: Color(0xFF64B5F6)),
              title: Text(
                'مدد اور تعاون',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }


  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
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
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Color(0xFF64B5F6),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.language, color: Colors.white),
                      SizedBox(width: 10),
                      Text(
                        'زبان منتخب کریں',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    children: [
                      // بلوچی
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.all(16),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.language, color: Colors.white),
                              SizedBox(width: 12),
                              Text(
                                'بلوچی',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // پشتو
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.all(16),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.language, color: Colors.white),
                              SizedBox(width: 12),
                              Text(
                                'پشتو',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),


                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.all(16),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.language, color: Colors.white),
                              SizedBox(width: 12),
                              Text(
                                'بروہی',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Color(0xFF64B5F6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                      ),
                      child: Text(
                        'منسوخ کریں',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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

  // Weather Card Widget
  Widget _buildWeatherCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF87CEEB),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Color(0xFF1565C0),
          width: 3,
        ),
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
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Sky Icon
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.orange.withOpacity(0.3)),
            ),
            child: ClipOval(
              child: Image.asset(
                "assets/images/sky.png",
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.wb_sunny, color: Colors.orange, size: 30);
                },
              ),
            ),
          ),
          SizedBox(width: 15),
          // Temperature Text
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '30°C',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E7D32),
                ),
              ),
              Text(
                'موسم',
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF2E7D32),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }


  Widget _buildMenuGrid() {
    List<Map<String, dynamic>> menuItems = [
      {
        'title': 'مویشی',
        'image': 'assets/images/animals.png',
        'color': Colors.blue,
      },
      {
        'title': 'فصلیں',
        'image': 'assets/images/crop.png',
        'color': Colors.green,
      },
      {
        'title': 'اوزار کی معلومات',
        'image': 'assets/images/Machinry info.png',
        'color': Colors.orange,
      },
      {
        'title': 'زرعی مشورے',
        'image': 'assets/images/Farming tips.png',
        'color': Colors.yellow[700]!,
      },
      {
        'title': 'تازہ ترین معلومات',
        'image': 'assets/images/Real time updates.png',
        'color': Colors.purple,
      },
      {
        'title': 'مارکیٹ',
        'image': 'assets/images/ChatGPT_Image_Dec_13__2025__09_51_56_PM-removebg-preview.png',
        'color': Colors.red,
      },
    ];

    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 8,
        childAspectRatio: 1.1,
      ),
      itemCount: menuItems.length,
      itemBuilder: (context, index) {
        return _buildMenuCard(
          menuItems[index]['title'],
          menuItems[index]['image'],
          menuItems[index]['color'],
        );
      },
    );
  }


  Widget _buildMenuCard(String title, String imagePath, Color color) {
    return GestureDetector(
      onTap: () {
        if (title == 'مویشی') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AnimalsScreen()),
          );
        } else if (title == 'فصلیں') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CityScreen()),
          );
        } else if (title == 'اوزار کی معلومات') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ToolsInfoScreen()),
          );
        } else if (title == 'زرعی مشورے') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FarmingTipsScreen()),
          );
        } else if (title == 'تازہ ترین معلومات') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AlertsScreen()),
          );
        } else if (title == 'مارکیٹ') {

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MarketScreen()),
          );
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Circular Image Container
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
              border: Border.all(
                color: color.withOpacity(0.3),
                width: 3,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 8,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: ClipOval(
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                width: 100,
                height: 100,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: color.withOpacity(0.2),
                    child: Icon(
                      Icons.image_not_supported,
                      color: color,
                      size: 40,
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 8),

          Container(
            height: 40,
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}