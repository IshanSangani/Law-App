import 'package:flutter/material.dart';
import 'package:law_app/sign_up.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key});

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
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1.0)),
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
                            const BorderSide(color: Colors.grey, width: 1.0)),
                  ),
                ),
                const SizedBox(height: 15.0),
                ElevatedButton(
                  onPressed: () {
                    // Add your authentication logic here
                    // This button is just for demonstration
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UserTypeSelection()),
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
