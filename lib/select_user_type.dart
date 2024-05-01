import 'package:flutter/material.dart';
import 'sign_up.dart'; // Importing user.dart

class SelectUserType extends StatefulWidget {
  const SelectUserType({super.key});

  @override
  _SelectUserTypeState createState() => _SelectUserTypeState();
}

class _SelectUserTypeState extends State<SelectUserType> {
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
                // Removed the image
                const SizedBox(height: 30.0),
                const Text(
                  'Select User Type',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10.0),
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
                          color: _selectedRole == 'user'
                              ? Colors.blue
                              : Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.person,
                                  color: _selectedRole == 'user'
                                      ? Colors.white
                                      : Colors.blue,
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  'User',
                                  style: TextStyle(
                                    color: _selectedRole == 'user'
                                        ? Colors.white
                                        : Colors.blue,
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
                          color: _selectedRole == 'lawyer'
                              ? Colors.blue
                              : Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.gavel,
                                  color: _selectedRole == 'lawyer'
                                      ? Colors.white
                                      : Colors.blue,
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  'Lawyer',
                                  style: TextStyle(
                                    color: _selectedRole == 'lawyer'
                                        ? Colors.white
                                        : Colors.blue,
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
                          color: _selectedRole == 'court'
                              ? Colors.blue
                              : Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.gavel,
                                  color: _selectedRole == 'court'
                                      ? Colors.white
                                      : Colors.blue,
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  'Court',
                                  style: TextStyle(
                                    color: _selectedRole == 'court'
                                        ? Colors.white
                                        : Colors.blue,
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

                const SizedBox(height: 15.0),
                ElevatedButton(
                  onPressed: () {
                    if (_selectedRole == 'user') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  SignUpPage()),
                      );
                    } else if (_selectedRole == 'lawyer') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  SignUpPage()),
                      );
                    } else if (_selectedRole == 'court') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignUpPage()),
                      );
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 10.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
