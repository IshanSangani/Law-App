import 'package:flutter/material.dart';

class UserTypeSelectionScreen extends StatelessWidget {
  const UserTypeSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select User Type'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/client_login');
              },
              child: const Text('Client'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/lawyer_login');
              },
              child: const Text('Lawyer'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/judge_login');
              },
              child: const Text('Judge/Court'),
            ),
          ],
        ),
      ),
    );
  }
}


