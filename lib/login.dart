import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'config.dart';
import 'package:law_app/lawyerpov.dart';
import 'package:law_app/court.dart';
import 'package:law_app/lawyers.dart';
import 'package:law_app/sign_up.dart';
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    final loginUrl = Uri.parse(login);
    final body = jsonEncode({'email': email, 'password': password});

    try {
      final response = await http.post(loginUrl,
          body: body, headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        final loginResponse = jsonDecode(response.body);

        if (loginResponse['status']) {
          final role = loginResponse['role'];
          _navigateToRoleScreen(role);
        } else {
          // Display error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(loginResponse['message']),
              backgroundColor: Colors.red,
            ),
          );
        }
      } else {
        throw Exception('Failed to login');
      }
    } catch (e) {
      // Handle login error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred during login'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _navigateToRoleScreen(String role) {
    final email = _emailController.text.trim();
    if (role == 'lawyer') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LawyerScreen( emailController: _emailController)),
      );
    } else if (role == 'user') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LawyersListScreen(emailController: _emailController)),
      );
    } else if (role == 'court') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CourtPOV()),
      );
    } else {
      // Handle other roles or scenarios
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid user role'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Background image
          Image.asset(
            'images/login_bg.jpg', // Replace with your image path
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
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
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  TextButton(
                    onPressed: _login,
                    style: TextButton.styleFrom(backgroundColor: Colors.blue),
                    child: const Text(
                      "Login",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  TextButton(
                    onPressed: () {
                      // Navigate to SignUpPage when the "Create an Account" button is clicked
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpPage()),
                      );
                    },
                    child: const Text('Create an Account'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
