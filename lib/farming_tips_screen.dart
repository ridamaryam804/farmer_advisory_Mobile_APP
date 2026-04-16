import 'package:flutter/material.dart';

class FarmingTipsScreen extends StatefulWidget {
  const FarmingTipsScreen({super.key});

  @override
  State<FarmingTipsScreen> createState() => _FarmingTipsScreenState();
}

class _FarmingTipsScreenState extends State<FarmingTipsScreen> {
  int _selectedCategory = 0; // 0 for crops, 1 for livestock

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF64B5F6),
      appBar: AppBar(
        title: Text(
          'Farming Tips',
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
            // Category Selection
            _buildCategorySelector(),
            SizedBox(height: 20),

            // Content based on selection
            Expanded(
              child: _selectedCategory == 0
                  ? _buildCropsTips()
                  : _buildLivestockTips(),
            ),
          ],
        ),
      ),
    );
  }

  // Category Selector Widget
  Widget _buildCategorySelector() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Color(0xFF1B5E20), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.3),
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Crops Button
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedCategory = 0;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  color: _selectedCategory == 0 ? Color(0xFF81C784) : Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(13),
                    bottomLeft: Radius.circular(13),
                  ),
                  border: _selectedCategory == 0
                      ? Border.all(color: Color(0xFF1B5E20), width: 2)
                      : null,
                ),
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/rice.png",
                      width: 50,
                      height: 50,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.agriculture,
                          color: _selectedCategory == 0 ? Colors.white : Color(0xFF1B5E20),
                          size: 35,
                        );
                      },
                    ),
                    SizedBox(height: 8),
                    Text(
                      'زراعت',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _selectedCategory == 0 ? Colors.white : Color(0xFF1B5E20),
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),


          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedCategory = 1;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  color: _selectedCategory == 1 ? Color(0xFF81C784) : Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(13),
                    bottomRight: Radius.circular(13),
                  ),
                  border: _selectedCategory == 1
                      ? Border.all(color: Color(0xFF1B5E20), width: 2)
                      : null,
                ),
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/livestock.png",
                      width: 50,
                      height: 50,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.pets,
                          color: _selectedCategory == 1 ? Colors.white : Color(0xFF1B5E20),
                          size: 35,
                        );
                      },
                    ),
                    SizedBox(height: 8),
                    Text(
                      'مویشی ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _selectedCategory == 1 ? Colors.white : Color(0xFF1B5E20),
                        fontSize: 16,
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

  // Crops Tips Content
  Widget _buildCropsTips() {
    List<Map<String, String>> cropsTips = [
      {
        'title': 'زراعت کی تجاویز',
        'subtitle': 'موسم کے مطابق کاشتکاری',
        'details': 'موسم کے مطابق مناسب بیج کا انتخاب کریں اور وقت پر کاشتکاری کریں۔'
      },
      {
        'title': 'کھاد کا استعمال',
        'subtitle': 'متوازن کھاد کا استعمال',
        'details': 'مٹی کی جانچ کے بعد ہی کھاد کا استعمال کریں۔'
      },
      {
        'title': 'آبپاشی',
        'subtitle': 'پانی کا مناسب استعمال',
        'details': 'پانی کو ضائع ہونے سے بچائیں اور ڈرپ ایریگیشن استعمال کریں۔'
      },
      {
        'title': 'کیڑے مار دوا',
        'subtitle': 'حفاظتی اقدامات',
        'details': 'کیڑے مار دوائیں استعمال کرتے وقت حفاظتی سامان پہنیں۔'
      },
    ];

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      itemCount: cropsTips.length,
      itemBuilder: (context, index) {
        return _buildTipCard(
          cropsTips[index]['title']!,
          cropsTips[index]['subtitle']!,
          cropsTips[index]['details']!,
          Colors.green,
        );
      },
    );
  }

  // Livestock Tips Content
  Widget _buildLivestockTips() {
    List<Map<String, String>> livestockTips = [
      {
        'title': 'مویشی پالن کی تجاویز',
        'subtitle': 'جانوروں کی صحت',
        'details': 'جانوروں کو باقاعدہ ویکسین لگوائیں اور صاف ستھرا ماحول دیں۔'
      },
      {
        'title': 'خوراک',
        'subtitle': 'متوازن خوراک',
        'details': 'جانوروں کو متوازن اور غذائیت سے بھرپور خوراک دیں۔'
      },
      {
        'title': 'رہائش',
        'subtitle': 'صاف ستھرا باڑا',
        'details': 'جانوروں کے رہنے کی جگہ صاف اور ہوا دار رکھیں۔'
      },
      {
        'title': 'دودھ کی پیداوار',
        'subtitle': 'بہتر دودھ کی پیداوار',
        'details': 'دودھ دینے والے جانوروں کا خصوصی خیال رکھیں۔'
      },
    ];

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      itemCount: livestockTips.length,
      itemBuilder: (context, index) {
        return _buildTipCard(
          livestockTips[index]['title']!,
          livestockTips[index]['subtitle']!,
          livestockTips[index]['details']!,
          Colors.blue,
        );
      },
    );
  }

  // Individual Tip Card
  Widget _buildTipCard(String title, String subtitle, String details, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: color.withOpacity(0.5), width: 2),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.2),
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title Row
            Row(
              children: [
                Container(
                  width: 8,
                  height: 30,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),

            // Details
            Text(
              details,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[800],
                height: 1.4,
              ),
              textAlign: TextAlign.right,
            ),

            SizedBox(height: 10),

            // Read More Button
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: color.withOpacity(0.3)),
                ),
                child: Text(
                  'مزید پڑھیں',
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}