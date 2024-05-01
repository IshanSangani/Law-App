import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'config.dart';

class CaseDetailsPage extends StatefulWidget {
  final TextEditingController emailController;

  const CaseDetailsPage({Key? key, required this.emailController}) : super(key: key);

  @override
  _CaseDetailsPageState createState() => _CaseDetailsPageState();
}

class _CaseDetailsPageState extends State<CaseDetailsPage> {
  String? caseDate;
  String? caseType;
  String? petitionerName;
  String? petitionerLawyerName;

  @override
  void initState() {
    super.initState();
    fetchCaseDetails(widget.emailController.text);
  }

  Future<void> fetchCaseDetails(String email) async {
  try {
    var regBody = {
      "email": email
    };
    var response = await http.post(Uri.parse(getcaseDetailsUrl),
        headers: {"Content-Type":"application/json"},
        body: jsonEncode(regBody)
    );

    // Print the status code and response body
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    var jsonResponse = jsonDecode(response.body);
    // Update the state variables with fetched data
    setState(() {
      caseDate = jsonResponse['hearingDate'];
      caseType = jsonResponse['caseType'];
      petitionerName = jsonResponse['petitionerName'];
      petitionerLawyerName = jsonResponse['petitionerLawyerName'];
    });
  } catch (error) {
    // Handle errors
    setState(() {
      caseDate = 'Error';
      caseType = 'Error';
      petitionerName = 'Error';
      petitionerLawyerName = 'Error';
    });
    print('Error fetching case details: $error');
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Case Details'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Case Date:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Text(
              caseDate ?? 'Loading...',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Case Type:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Text(
              caseType ?? 'Loading...',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Petitioner Name:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Text(
              petitionerName ?? 'Loading...',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Petitioner Lawyer Name:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Text(
              petitionerLawyerName ?? 'Loading...',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
