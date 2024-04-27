import 'package:flutter/material.dart';
import 'package:law_app/lawyers.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'bottom_nav_bar.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  _ChatBotScreenState createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  int currentIndex = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChatBot'),
      ),
      body: const WebView(
        initialUrl: 'https://askyourpdf.com/', // Replace with your website URL
        javascriptMode: JavascriptMode.unrestricted,
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
          // Handle navigation based on the selected tab
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LawyersListScreen()),
              );
              break;
            case 1:
              // Navigate to Settings screen
              break;
            case 2:
              // Already on ChatBot screen
              break;
            case 3:
              // Navigate to Profile screen
              break;
          }
        },
      ),
    );
  }
}
