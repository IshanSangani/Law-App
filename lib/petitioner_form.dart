import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'config.dart';

List<String> courtList = ['Supreme Court', 'High Court', 'District Court'];
String? courtDropdownValue;

class CaseFilingForm extends StatefulWidget {
  final TextEditingController emailController;

  const CaseFilingForm({Key? key, required this.emailController}) : super(key: key);

  @override
  _CaseFilingFormState createState() => _CaseFilingFormState();
}

class _CaseFilingFormState extends State<CaseFilingForm> {
  final _formKey = GlobalKey<FormState>();
  List<PlatformFile> selectedFiles = [];

  final TextEditingController _caseTypeController = TextEditingController();
  final TextEditingController _petitionerNameController = TextEditingController();
  final TextEditingController _petitionerAgeController = TextEditingController();
  final TextEditingController _petitionerLawyerController = TextEditingController();
  final TextEditingController _petitionerLawyerEmailController = TextEditingController();
  final TextEditingController _respondentNameController = TextEditingController();
  final TextEditingController _respondentAgeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Case matter details'),
        backgroundColor: Colors.blue,
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          )
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Fill case matter details',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: DropdownButtonFormField<String>(
                    value: courtDropdownValue,
                    onChanged: (String? value) {
                      setState(() {
                        courtDropdownValue = value!;
                      });
                    },
                    items: courtList.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    decoration: const InputDecoration(
                      labelText: 'Select Court',
                      labelStyle: TextStyle(
                        fontSize: 14,
                      ),
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 5.0, horizontal: 12.0),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _caseTypeController,
                  decoration: const InputDecoration(
                    labelText: 'Case Type',
                    labelStyle: TextStyle(
                      fontSize: 14,
                    ),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter case type';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _petitionerNameController,
                  decoration: const InputDecoration(
                    labelText: 'Petitioner Name',
                    labelStyle: TextStyle(
                      fontSize: 12,
                    ),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter petitioner name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _petitionerAgeController,
                  decoration: const InputDecoration(
                    labelText: 'Petitioner Age',
                    labelStyle: TextStyle(
                      fontSize: 12,
                    ),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter petitioner age';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _petitionerLawyerController,
                  decoration: const InputDecoration(
                    labelText: 'Petitioner Lawyer Name',
                    labelStyle: TextStyle(
                      fontSize: 12,
                    ),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter petitioner lawyer name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _petitionerLawyerEmailController,
                  decoration: const InputDecoration(
                    labelText: 'Petitioner Lawyer Email',
                    labelStyle: TextStyle(
                      fontSize: 12,
                    ),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter petitioner lawyer email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _respondentNameController,
                  decoration: const InputDecoration(
                    labelText: 'Respondent Name',
                    labelStyle: TextStyle(
                      fontSize: 12,
                    ),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter respondent name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _respondentAgeController,
                  decoration: const InputDecoration(
                    labelText: 'Respondent Age',
                    labelStyle: TextStyle(
                      fontSize: 12,
                    ),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter respondent age';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles(
                        allowMultiple: true,
                        type: FileType.custom,
                        allowedExtensions: ['pdf', 'doc', 'docx'],
                      );
                      if (result != null) {
                        setState(() {
                          selectedFiles = result.files;
                        });
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Permission denied for file access.'),
                        ),
                      );
                    }
                  },
                  child: const Text('Upload Documents'),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Selected Files:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: selectedFiles.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(selectedFiles[index].name),
                    );
                  },
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      submitForm();
                    }
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void submitForm() async {
    final Map<String, dynamic> requestBody = {
      'caseType': _caseTypeController.text,
      'petitionerName': _petitionerNameController.text,
      'petitionerAge': _petitionerAgeController.text,
      'petitionerLawyerName': _petitionerLawyerController.text,
      'petitionerLawyerEmail': _petitionerLawyerEmailController.text,
      'respondentName': _respondentNameController.text,
      'respondentAge': _respondentAgeController.text,
      'petitioneremail': widget.emailController.text, // Using emailController passed from parent
    };

    try {
      final response = await http.post(
        Uri.parse(createToDoUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SuccessPage()),
        );
      } else {
        throw Exception('Failed to submit form');
      }
    } catch (error) {
      print('Error: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    }
  }
}

class SuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Success'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.check_circle, color: Colors.green, size: 50),
            SizedBox(height: 16),
            Text('Form submitted successfully!',
                style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}