import 'package:flutter/material.dart';
import 'package:law_app/lawyers.dart'; // Importing user.dart
import 'package:law_app/court.dart'; // Importing user.dart
import 'package:law_app/sign_up.dart';
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? _selectedRole;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  'images/login.jpg', // Adjust the image path as needed
                  height: 150, // Adjust the image height as needed
                ),
                const SizedBox(height: 30.0),
                const Text(
                  'Welcome to Law App!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10.0),
                const Text(
                  'Login to continue to the app',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedRole = 'user';
                          });
                        },
                        child: Card(
                          elevation: 3,
                          color: _selectedRole == 'user' ? Colors.blue : Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.person,
                                  color: _selectedRole == 'user' ? Colors.white : Colors.blue,
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  'User',
                                  style: TextStyle(
                                    color: _selectedRole == 'user' ? Colors.white : Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedRole = 'lawyer';
                          });
                        },
                        child: Card(
                          elevation: 3,
                          color: _selectedRole == 'lawyer' ? Colors.blue : Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.gavel,
                                  color: _selectedRole == 'lawyer' ? Colors.white : Colors.blue,
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  'Lawyer',
                                  style: TextStyle(
                                    color: _selectedRole == 'lawyer' ? Colors.white : Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedRole = 'court';
                          });
                        },
                        child: Card(
                          elevation: 3,
                          color: _selectedRole == 'court' ? Colors.blue : Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.gavel,
                                  color: _selectedRole == 'court' ? Colors.white : Colors.blue,
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  'Court',
                                  style: TextStyle(
                                    color: _selectedRole == 'court' ? Colors.white : Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 1.0),
                    ),
                  ),
                ),
                const SizedBox(height: 15.0),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 1.0),
                    ),
                  ),
                ),
                const SizedBox(height: 15.0),
                ElevatedButton(
                  onPressed: () {
                    if (_selectedRole == 'user') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LawyersListScreen()),
                      );
                    } else if (_selectedRole == 'lawyer') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CourtPOV()),
                      );
                    } else if (_selectedRole == 'court') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CourtPOV()),
                      );
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 10.0),
                TextButton(
                  onPressed: () {
                    // Navigate to user.dart when the "Create an Account" button is clicked
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignupPage()),
                    );
                  },
                  child: const Text('Create an Account'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}