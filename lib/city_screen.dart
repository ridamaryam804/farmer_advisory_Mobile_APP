import 'package:flutter/material.dart';

class CityScreen extends StatefulWidget {
  const CityScreen({super.key});

  @override
  State<CityScreen> createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String? _selectedDivision;

  final List<String> _divisions = [
    'فلات ڈویژن',
    'مکران ڈویژن',
    'کوئٹہ ڈویژن',
    'نصیر آباد ڈویژن',
    'سبی ڈویژن',
    'ژوب ڈویژن',
    'رخشان ڈویژن',
    'لورالائی ڈویژن',
    'خاران ڈویژن',
    'پشین ڈویژن',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF64B5F6),
      appBar: AppBar(
        title: Text(
          'علاقہ منتخب کریں',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xFF64B5F6),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
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
            // Show Information Message when a city is selected - MIDDLE TOP
            if (_selectedDivision != null)
              _buildInfoMessage(),

            SizedBox(height: 20),

            // Divisions List - BELOW THE MESSAGE
            Expanded(
              child: ListView.builder(
                itemCount: _divisions.length,
                itemBuilder: (context, index) {
                  // Alternate colors for rows
                  Color rowColor = index % 2 == 0
                      ? Color(0xFF18ACC0)  // First row color
                      : Color(0xFF79CBFE); // Second row color

                  return _buildDivisionCard(_divisions[index], rowColor);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivisionCard(String divisionName, Color rowColor) {
    bool isSelected = _selectedDivision == divisionName;

    // Darker version of the row color when selected
    Color selectedColor = _darkenColor(rowColor, 0.3);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      decoration: BoxDecoration(
        color: isSelected ? selectedColor : rowColor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: isSelected ? Colors.white : Colors.white.withOpacity(0.3),
          width: 2,
        ),
        boxShadow: [

          BoxShadow(
            color: rowColor.withOpacity(0.6),
            blurRadius: 15,
            spreadRadius: 2,
            offset: Offset(0, 0),
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.2),
            blurRadius: 8,
            spreadRadius: 1,
            offset: Offset(0, 0),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.3),
                blurRadius: 5,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Icon(
            Icons.location_on,
            color: Colors.white,
            size: 24,
          ),
        ),
        title: Text(
          divisionName,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textAlign: TextAlign.right,
        ),
        trailing: isSelected
            ? Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.yellow.withOpacity(0.6),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Icon(
            Icons.check_circle,
            color: Colors.yellow,
            size: 28,
          ),
        )
            : null,
        onTap: () {
          setState(() {
            _selectedDivision = divisionName;
          });
        },
      ),
    );
  }

  Widget _buildInfoMessage() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.all(20),
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
          BoxShadow(
            color: Colors.white.withOpacity(0.2),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        children: [
          // Main Icon
          Icon(
            Icons.agriculture,
            color: Color(0xFFF2C112),
            size: 60,
          ),

          SizedBox(height: 15),

          // Title
          Text(
            'آپ کے شہر کی فصلیں',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFFF2C112),
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 10),

          // Message
          Text(
            '$_selectedDivision سے متعلق فصلیں اور ان کی مکمل معلومات جلد ہی اپ لوڈ کر دی جائیں گی۔',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 15),

          // Thank You Message
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Color(0xFFF2C112), width: 2),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.hourglass_bottom,
                  color: Color(0xFFF2C112),
                  size: 20,
                ),
                SizedBox(width: 8),
                Text(
                  'انتظار کا شکریہ',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFF2C112),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 10),

          // Progress Indicator
          LinearProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFF2C112)),
            backgroundColor: Colors.white.withOpacity(0.3),
            minHeight: 6,
            borderRadius: BorderRadius.circular(10),
          ),
        ],
      ),
    );
  }

  // Helper function to darken a color
  Color _darkenColor(Color color, double factor) {
    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - factor).clamp(0.0, 1.0));
    return hslDark.toColor();
  }
}