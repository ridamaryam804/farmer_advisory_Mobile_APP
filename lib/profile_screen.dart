import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, String> userProfile = {
    'username': '',
    'mobile': '',
    'location': 'Balochistan, Quetta',
    'joinDate': '',
  };

  bool _isDataLoaded = false;
  bool _hasAccount = false;
  bool _popupShown = false;

  // For profile image
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  // Text editing controllers for edit functionality
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
    _loadProfileImage();
  }

  Future<void> _loadProfileImage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final imagePath = prefs.getString('profileImagePath');
      if (imagePath != null && imagePath.isNotEmpty) {
        setState(() {
          _profileImage = File(imagePath);
        });
      }
    } catch (e) {
      print('❌ Error loading profile image: $e');
    }
  }

  Future<void> _saveProfileImage(String path) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('profileImagePath', path);
    } catch (e) {
      print('❌ Error saving profile image: $e');
    }
  }

  Future<void> _loadUserProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();


      final username = prefs.getString('username') ?? '';
      final mobile = prefs.getString('mobile') ?? '';
      final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
      final joinDate = prefs.getString('joinDate') ?? '';

      print('🔍 Profile Loading Check:');
      print('Username: $username');
      print('Mobile: $mobile');
      print('isLoggedIn: $isLoggedIn');
      print('Join Date: $joinDate');

      setState(() {

        _hasAccount = username.isNotEmpty || mobile.isNotEmpty || isLoggedIn;

        if (_hasAccount) {
          userProfile = {
            'username': username.isNotEmpty ? username : 'No username',
            'mobile': mobile.isNotEmpty ? mobile : 'No mobile number',
            'location': 'Balochistan, Quetta',
            'joinDate': joinDate.isNotEmpty ? joinDate : '2024-01-01',
          };

          // Update text controllers with current data
          _usernameController.text = username.isNotEmpty ? username : '';
          _mobileController.text = mobile.isNotEmpty ? mobile : '';
        } else {
          userProfile = {
            'username': '',
            'mobile': '',
            'location': 'Balochistan, Quetta',
            'joinDate': '',
          };
        }
        _isDataLoaded = true;
      });

    } catch (e) {
      print('❌ Error loading profile: $e');
      setState(() {
        _isDataLoaded = true;
        _hasAccount = false;
      });
    }
  }


  Future<void> _selectProfileImage() async {
    print('📱 Opening image selection options...');

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt, color: Color(0xFF64B5F6)),
                title: Text('Take Photo'),
                onTap: () {
                  print('📸 Camera option selected');
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library, color: Color(0xFF64B5F6)),
                title: Text('Choose from Gallery'),
                onTap: () {
                  print('🖼️ Gallery option selected');
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
              if (_profileImage != null)
                ListTile(
                  leading: Icon(Icons.delete, color: Colors.red),
                  title: Text('Remove Photo', style: TextStyle(color: Colors.red)),
                  onTap: () {
                    print('🗑️ Remove photo option selected');
                    Navigator.pop(context);
                    _removeProfileImage();
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _profileImage = File(pickedFile.path);
        });
        await _saveProfileImage(pickedFile.path);
        print('✅ Image selected: ${pickedFile.path}');
      }
    } catch (e) {
      print('❌ Error picking image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error selecting image!'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _removeProfileImage() async {
    setState(() {
      _profileImage = null;
    });
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('profileImagePath');
    print('✅ Profile image removed');
  }


  void _editProfile() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              Icon(Icons.edit, color: Color(0xFF64B5F6)),
              SizedBox(width: 10),
              Text(
                'Edit Profile',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    labelStyle: TextStyle(color: Color(0xFF64B5F6)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Color(0xFF64B5F6)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Color(0xFF64B5F6), width: 2),
                    ),
                    prefixIcon: Icon(Icons.person, color: Color(0xFF64B5F6)),
                  ),
                  style: TextStyle(color: Color(0xFF64B5F6)), // Blue text
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _mobileController,
                  decoration: InputDecoration(
                    labelText: 'Mobile Number',
                    labelStyle: TextStyle(color: Color(0xFF64B5F6)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Color(0xFF64B5F6)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Color(0xFF64B5F6), width: 2),
                    ),
                    prefixIcon: Icon(Icons.phone, color: Color(0xFF64B5F6)),
                  ),
                  keyboardType: TextInputType.phone,
                  style: TextStyle(color: Color(0xFF64B5F6)), // Blue text
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF64B5F6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () async {
                await _saveProfileChanges();
                Navigator.pop(context);
              },
              child: Text(
                'Save',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }


  Future<void> _saveProfileChanges() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Save new data to shared preferences
      await prefs.setString('username', _usernameController.text.trim());
      await prefs.setString('mobile', _mobileController.text.trim());

      // Update local state
      setState(() {
        userProfile['username'] = _usernameController.text.trim();
        userProfile['mobile'] = _mobileController.text.trim();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Profile updated successfully!'),
          backgroundColor: Colors.green,
        ),
      );

    } catch (e) {
      print('❌ Error saving profile: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error updating profile!'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }


  void _logout() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              Icon(Icons.logout, color: Color(0xFF64B5F6)), // Blue icon
              SizedBox(width: 10),
              Text(
                'Logout',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: Text(
            'Are you sure you want to logout? All your profile data will be cleared.',
            style: TextStyle(
              color: Colors.grey[700],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
            //  BLUE LOGOUT BUTTON
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF64B5F6), // Blue background
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () async {
                await _clearUserData();
                Navigator.pop(context);
                Navigator.pop(context); // Go back to previous screen
              },
              child: Text(
                'Logout',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  //  CLEAR USER DATA FUNCTION
  Future<void> _clearUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Clear all user-related data
      await prefs.remove('username');
      await prefs.remove('mobile');
      await prefs.remove('isLoggedIn');
      await prefs.remove('joinDate');
      await prefs.remove('profileImagePath');

      // Update state
      setState(() {
        _hasAccount = false;
        _profileImage = null;
        userProfile = {
          'username': '',
          'mobile': '',
          'location': 'Balochistan, Quetta',
          'joinDate': '',
        };
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Logged out successfully!'),
          backgroundColor: Colors.green,
        ),
      );

    } catch (e) {
      print('❌ Error during logout: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error during logout!'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showSignupPopup() {
    if (_popupShown) return;

    _popupShown = true;

    print('🔄 Showing signup popup...');

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              Icon(Icons.person_add, color: Color(0xFF64B5F6)),
              SizedBox(width: 10),
              Text(
                'Create Account',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: Text(
            'Please create an account first to access your profile.',
            style: TextStyle(
              color: Colors.grey[700],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close popup
                Navigator.pop(context); // Go back to previous screen
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF64B5F6), // Blue background
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Navigator.pop(context); // Close popup
                Navigator.pop(context); // Go back to previous screen
              },
              child: Text(
                'Sign Up',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    ).then((value) {
      _popupShown = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF64B5F6), // Light Blue
              Color(0xFF81C784), // Light Green
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(
              'My Profile',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: _hasAccount ? [
              IconButton(
                icon: Icon(Icons.edit, color: Colors.white),
                onPressed: _editProfile,
              ),
              IconButton(
                icon: Icon(Icons.logout, color: Colors.white),
                onPressed: _logout,
              ),
            ] : [],
          ),
          body: _buildBody(),
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (!_isDataLoaded) {
      return _buildLoading();
    }


    if (!_hasAccount) {
      print('🚨 No account found - Direct popup show');

      // ✅ IMMEDIATELY SHOW POPUP
      Future.delayed(Duration.zero, () {
        _showSignupPopup();
      });

      return _buildNoDataView();
    }

    print('✅ Account found - showing profile data');
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildProfileHeader(),
          SizedBox(height: 24),
          _buildProfileDetails(),
          SizedBox(height: 20),
          _buildActionButtons(),
        ],
      ),
    );
  }


  Widget _buildActionButtons() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Expanded(
            child: Container(
              margin: EdgeInsets.only(right: 8),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Color(0xFF64B5F6),
                  padding: EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  side: BorderSide(
                    color: Color(0xFF64B5F6),
                    width: 2,
                  ),
                  elevation: 2,
                ),
                onPressed: _editProfile,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.edit, size: 18, color: Color(0xFF64B5F6)),
                    SizedBox(width: 6),
                    Text(
                      'Edit Profile',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF64B5F6),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),


          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 8),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Color(0xFF64B5F6),
                  padding: EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  side: BorderSide(
                    color: Color(0xFF64B5F6),
                    width: 2,
                  ),
                  elevation: 2,
                ),
                onPressed: _logout,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout, size: 18, color: Color(0xFF64B5F6)),
                    SizedBox(width: 6),
                    Text(
                      'Logout',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF64B5F6),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: Colors.white,
          ),
          SizedBox(height: 16),
          Text(
            'Loading Profile...',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoDataView() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.9),
                border: Border.all(
                  color: Color(0xFF64B5F6),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF64B5F6).withOpacity(0.5),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Icon(
                Icons.person_outline,
                size: 50,
                color: Color(0xFF64B5F6),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'No Profile Data',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 12),
            Text(
              'Please sign up first to view your profile',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 30),

            OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Color(0xFF64B5F6),
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                side: BorderSide(
                  color: Color(0xFF64B5F6),
                  width: 2,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Go Back',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF64B5F6),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        children: [

          Stack(
            children: [
              GestureDetector(
                onTap: () {
                  print('🎯 Profile picture clicked!');
                  _selectProfileImage();
                },
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.9),
                    border: Border.all(
                      color: Color(0xFF64B5F6),
                      width: 3,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF64B5F6).withOpacity(0.5),
                        blurRadius: 15,
                        spreadRadius: 3,
                      ),
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: _profileImage != null
                        ? Image.file(
                      _profileImage!,
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    )
                        : Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      padding: EdgeInsets.all(25),
                      child: Icon(
                        Icons.person,
                        color: Color(0xFF64B5F6),
                        size: 60,
                      ),
                    ),
                  ),
                ),
              ),

              // Camera Icon
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    color: Color(0xFF64B5F6),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 20),

          if (userProfile['username']!.isNotEmpty && userProfile['username'] != 'No username')
            Text(
              '@${userProfile['username']!}',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(1, 1),
                  ),
                ],
              ),
            ),

          SizedBox(height: 8),

          if (userProfile['joinDate']!.isNotEmpty)
            Text(
              'Member since ${userProfile['joinDate']!}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withOpacity(0.9),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildProfileDetails() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          if (userProfile['username']!.isNotEmpty && userProfile['username'] != 'No username')
            Column(
              children: [
                _buildModernProfileItem('Username', userProfile['username']!, Icons.person_outline),
                SizedBox(height: 12),
              ],
            ),

          if (userProfile['mobile']!.isNotEmpty && userProfile['mobile'] != 'No mobile number')
            Column(
              children: [
                _buildModernProfileItem('Mobile Number', userProfile['mobile']!, Icons.phone_iphone_outlined),
                SizedBox(height: 12),
              ],
            ),

          _buildModernProfileItem('Location', userProfile['location']!, Icons.location_on_outlined),
        ],
      ),
    );
  }


  Widget _buildModernProfileItem(String title, String value, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Color(0xFF64B5F6),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF64B5F6).withOpacity(0.5),
            blurRadius: 10,
            spreadRadius: 2,
            offset: Offset(0, 0),
          ),
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF64B5F6),
                Color(0xFF81C784),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[700],
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          value,
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF64B5F6),
            fontWeight: FontWeight.w600,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _mobileController.dispose();
    super.dispose();
  }
}