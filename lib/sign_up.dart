import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:velocity_x/velocity_x.dart';

import 'login.dart';
import 'package:http/http.dart' as http;
import 'config.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isNotValidate = false;
  String? _selectedRole;

  void registerUser() async {
  try {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty && _selectedRole != null) {
      var regBody = {
        "email": emailController.text,
        "password": passwordController.text,
        "role": _selectedRole, // Pass the selected role
      };

      var response = await http.post(
        Uri.parse(registration),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody),
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse['status']) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
        } else {
          // Display the error message from the backend
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(jsonResponse['message']),
              backgroundColor: Colors.red,
            ),
          );
        }
      } else {
        // Display a generic error message
        var errorMessage = 'Something went wrong. Please try again.';
        if (response.body.isNotEmpty) {
          var jsonResponse = jsonDecode(response.body);
          errorMessage = jsonResponse['message'] ?? errorMessage;
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      setState(() {
        _isNotValidate = true;
      });
    }
  } catch (e) {
    print("Error: $e");
  }
}
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color.fromARGB(255, 201, 198, 197), Color.fromARGB(255, 184, 182, 180)],
              begin: FractionalOffset.topLeft,
              end: FractionalOffset.bottomCenter,
              stops: [0.0, 0.8],
              tileMode: TileMode.mirror,
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  HeightBox(10),
                  "CREATE YOUR ACCOUNT".text.size(22).yellow100.make(),
                  // Cards for user, lawyer, and court selection
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // User card
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
                      // Lawyer card
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
                      // Court card
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
                  const SizedBox(height: 15.0),
                  // Email and password fields
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      errorStyle: TextStyle(color: Colors.white),
                      errorText: _isNotValidate ? "Enter Proper Info" : null,
                      hintText: "Email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                  ).p4().px24(),
                  TextField(
                    controller: passwordController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(Icons.copy),
                        onPressed: () {
                          final data = ClipboardData(text: passwordController.text);
                          Clipboard.setData(data);
                        },
                      ),
                      prefixIcon: IconButton(
                        icon: Icon(Icons.password),
                        onPressed: () {
                          String passGen = generatePassword();
                          passwordController.text = passGen;
                          setState(() {});
                        },
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      errorStyle: TextStyle(color: Colors.white),
                      errorText: _isNotValidate ? "Enter Proper Info" : null,
                      hintText: "Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                  ).p4().px24(),
                  HStack([
                    GestureDetector(
                      onTap: () => registerUser(),
                      child: VxBox(child: "Register".text.white.makeCentered().p16()).green600.roundedLg.make().px16().py16(),
                    ),
                  ]),
                  GestureDetector(
                    onTap: () {
                      print("Sign In");
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    child: HStack([
                      "Already Registered?".text.make(),
                      " Sign In".text.white.make(),
                    ]).centered(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String generatePassword() {
    String upper = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    String lower = 'abcdefghijklmnopqrstuvwxyz';
    String numbers = '1234567890';
    String symbols = '!@#\$%^&*()<>,./';

    String password = '';
    int passLength = 20;
    String seed = upper + lower + numbers + symbols;

    List<String> list = seed.split('').toList();
    Random rand = Random();

    for (int i = 0; i < passLength; i++) {
      int index = rand.nextInt(list.length);
      password += list[index];
    }
    return password;
  }
}