import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ChatBotScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ChatBot'),
      ),
      body: WebView(
        initialUrl: 'https://askyourpdf.com/', // Replace with your website URL
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
