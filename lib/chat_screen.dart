import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'dart:math' as math;
import '../main.dart';
import 'login_page.dart';

class ChatScreen extends StatefulWidget {
  final bool hasAccount;

  const ChatScreen({super.key, this.hasAccount = false});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  final TextEditingController _messageController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _showAccountPopup = true;
  late bool _hasAccount;


  List<Map<String, dynamic>> _messages = [];

  @override
  void initState() {
    super.initState();

    _hasAccount = widget.hasAccount;

    _controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _colorAnimation = ColorTween(
      begin: Color(0xFF64B5F6), // Blue
      end: Color(0xFF81C784), // Green
    ).animate(_controller);

    if (_hasAccount) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _focusNode.requestFocus();
      });


      _addWelcomeMessage();
    } else {
      _focusNode.unfocus();
    }
  }


  void _addWelcomeMessage() {
    setState(() {
      _messages.add({
        'text': 'Hello! Welcome to our support chat. How can we help you today?',
        'isMe': false,
        'time': DateTime.now(),
      });
    });
  }


  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      setState(() {
        _messages.add({
          'text': _messageController.text.trim(),
          'isMe': true,
          'time': DateTime.now(),
        });
        _messageController.clear();
      });


      _simulateAutoReply();
    }
  }


  void _simulateAutoReply() {
    Future.delayed(Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _messages.add({
            'text': 'Thank you for your message. Our support team will get back to you shortly.',
            'isMe': false,
            'time': DateTime.now(),
          });
        });
      }
    });
  }

  String _formatTime(DateTime time) {
    final hour = time.hour % 12 == 0 ? 12 : time.hour % 12;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.hour < 12 ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  @override
  void dispose() {
    _controller.dispose();
    _messageController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _navigateToSignup() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignupPage()),
    ).then((value) {
      if (value == true) { // Signup successful
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        ).then((loginValue) {
          if (loginValue == true) {
            setState(() {
              _hasAccount = true;
              _showAccountPopup = false;
            });
            _addWelcomeMessage();
            _focusNode.requestFocus();
          }
        });
      }
    });
  }

  void _navigateToLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    ).then((loginValue) {
      if (loginValue == true) {
        setState(() {
          _hasAccount = true;
          _showAccountPopup = false;
        });
        _addWelcomeMessage();
        _focusNode.requestFocus();
      }
    });
  }

  void _closePopup() {
    setState(() {
      _showAccountPopup = false;
    });
  }

  void _showMustHaveAccountMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('You must create an account first to start chatting'),
        backgroundColor: Colors.red[700],
        duration: Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'چیٹ سپورٹ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xFF64B5F6),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          // MAIN BACKGROUND
          Container(
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
            child: Column(
              children: [

                Expanded(
                  child: _hasAccount
                      ? _buildChatMessages()
                      : _buildWelcomeScreen(),
                ),


                _buildMessageInput(),
              ],
            ),
          ),


          if (_showAccountPopup && !_hasAccount)
            _buildAccountPopup(),
        ],
      ),
    );
  }


  Widget _buildChatMessages() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: ListView.builder(
        reverse: false,
        itemCount: _messages.length,
        itemBuilder: (context, index) {
          final message = _messages[index];
          return _buildMessageBubble(
            text: message['text'],
            isMe: message['isMe'],
            time: message['time'],
          );
        },
      ),
    );
  }


  Widget _buildMessageBubble({required String text, required bool isMe, required DateTime time}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isMe)
            CircleAvatar(
              radius: 16,
              backgroundColor: Colors.white.withOpacity(0.3),
              child: Icon(Icons.support_agent, size: 16, color: Colors.white),
            ),

          Flexible(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: isMe ? Colors.white : Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 2,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: 15,
                      color: isMe ? Colors.black87 : Colors.black87,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    _formatTime(time),
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ),

          if (isMe)
            CircleAvatar(
              radius: 16,
              backgroundColor: Colors.white.withOpacity(0.3),
              child: Icon(Icons.person, size: 16, color: Colors.white),
            ),
        ],
      ),
    );
  }


  Widget _buildWelcomeScreen() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.chat_bubble_outline,
              size: 40,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 20),
          Text(
            'چیٹنگ شروع کرنے کے لیے اکاؤنٹ بنائیں',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.normal,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }


  Widget _buildMessageInput() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom + 10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, -2),
          ),
        ],

      ),
      child: Row(
        children: [
          // Attachment icon
          Container(
            margin: EdgeInsets.only(right: 8),
            child: CircleAvatar(
              backgroundColor: Colors.grey[300],
              radius: 22,
              child: IconButton(
                icon: Icon(Icons.attach_file, color: Colors.grey[600], size: 20),
                padding: EdgeInsets.zero,
                onPressed: () {
                  if (!_hasAccount) {
                    _showMustHaveAccountMessage();
                  }
                },
              ),
            ),
          ),

          // Message Input Field
          Expanded(
            child: AbsorbPointer(
              absorbing: !_hasAccount,
              child: Opacity(
                opacity: _hasAccount ? 1.0 : 0.5,
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: Colors.grey[300]!,
                      width: 1,
                    ),
                  ),
                  child: TextField(
                    controller: _messageController,
                    focusNode: _focusNode,
                    decoration: InputDecoration(
                      hintText: _hasAccount ? 'Type a message...' : 'Create account to chat...',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      hintStyle: TextStyle(color: Colors.grey[600], fontSize: 15),
                    ),
                    onTap: () {
                      if (!_hasAccount) {
                        _showMustHaveAccountMessage();
                      }
                    },
                    onSubmitted: (value) {
                      if (_hasAccount && value.isNotEmpty) {
                        _sendMessage();
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 8),

          // Send Button
          AbsorbPointer(
            absorbing: !_hasAccount,
            child: Opacity(
              opacity: _hasAccount ? 1.0 : 0.5,
              child: CircleAvatar(
                radius: 22,
                backgroundColor: _hasAccount ? Color(0xFF64B5F6) : Colors.grey[400],
                child: IconButton(
                  icon: Icon(
                    Icons.send,
                    color: Colors.white,
                    size: 20,
                  ),
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    if (_hasAccount && _messageController.text.isNotEmpty) {
                      _sendMessage();
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountPopup() {
    return Container(
      color: Colors.black.withOpacity(0.7),
      child: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.85,
            margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 50),
            padding: EdgeInsets.all(25),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF64B5F6),
                  Color(0xFF81C784),
                ],
              ),
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
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.account_circle, size: 60, color: Colors.white),
                SizedBox(height: 15),

                AnimatedBuilder(
                  animation: _colorAnimation,
                  builder: (context, child) {
                    return Text(
                      'اکاؤنٹ ضروری ہے',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    );
                  },
                ),
                SizedBox(height: 10),

                Text(
                  'ہماری سپورٹ ٹیم سے چیٹ شروع کرنے کے لیے پہلے آپ کو اکاؤنٹ بنانا ہوگا',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 25),


                SizedBox(
                  width: double.infinity,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
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
                        padding: EdgeInsets.symmetric(vertical: 10),
                        minimumSize: Size(0, 45),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      onPressed: _navigateToSignup,
                      child: Text(
                        'ابھی سائن اپ کریں',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),


                SizedBox(
                  width: double.infinity,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.6),
                          blurRadius: 10,
                          spreadRadius: 1,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 10),
                        minimumSize: Size(0, 45),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                          side: BorderSide(color: Color(0xFF1B5E20), width: 2),
                        ),
                      ),
                      onPressed: _navigateToLogin,
                      child: Text(
                        'میرا پہلے سے اکاؤنٹ موجود ہے',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF1B5E20),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),


                TextButton(
                  onPressed: _closePopup,
                  child: Text(
                    'فی الحال چھوڑ دیں',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );}}