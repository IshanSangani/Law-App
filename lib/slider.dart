import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'login.dart';

class SliderScreen extends StatefulWidget {
  const SliderScreen({super.key});

  @override
  State<SliderScreen> createState() => _SliderScreenState();
}

class _SliderScreenState extends State<SliderScreen> {
  List<Map<String, dynamic>> slides = [];
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    slides = [
      {
        "title": "Welcome to Law App!",
        "description": "Your all-in-one platform for legal services. Whether you're a client seeking legal assistance, a lawyer offering your expertise, or a judge presiding over cases, we have the tools and resources to meet your needs.",
        "textAlignDescription": TextAlign.center,
        "backgroundColor": Colors.white,
        "styleTitle": const TextStyle(color: Colors.green, fontSize:30, fontFamily:'Poppins', fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
        "styleDescription": const TextStyle(color: Colors.blue, fontSize: 20, fontFamily: 'Helvetica', fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
      },
      {
        "title": "Legal Support for Clients",
        "description": "As a client, gain access to a network of experienced lawyers, receive personalized legal advice, and track the progress of your cases—all in one place.",
        "backgroundColor": Colors.white,
        "styleTitle": const TextStyle(color: Colors.green, fontSize:30, fontFamily:'Poppins', fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
        "styleDescription": const TextStyle(color: Colors.blue, fontSize: 20, fontFamily: 'Helvetica', fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
      },
      {
        "title": "Tools for Legal Professionals",
        "description": "Lawyers can manage their caseload efficiently, collaborate with clients, and stay organized with our suite of productivity tools designed specifically for legal professionals.",
        "backgroundColor": Colors.white,
        "styleTitle": const TextStyle(color: Colors.green, fontSize:30, fontFamily:'Poppins', fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
        "styleDescription": const TextStyle(color: Colors.blue, fontSize: 20, fontFamily: 'Helvetica', fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
      },
      {
        "title": "Judicial Resources and Insights",
        "description": "Judges can stay informed with legal updates, access precedents and case law, and streamline courtroom proceedings using our platform tailored for judicial needs.",
        "backgroundColor": Colors.white,
        "styleTitle": const TextStyle(color: Colors.green, fontSize:30, fontFamily:'Poppins', fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
        "styleDescription": const TextStyle(color: Colors.blue, fontSize: 20, fontFamily: 'Helvetica', fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Slider Screen'),
      ),
      body: IntroSlider(
        listContentConfig: slides.map((slide) {
          return ContentConfig(
            title: slide["title"],
            description: slide["description"],
            styleTitle: slide["styleTitle"],
            styleDescription: slide["styleDescription"],
          );
        }).toList(),
        onSkipPress: () {
          _navigateToLogin();
        },
        onDonePress: () {
          _navigateToLogin();
        },
        onNextPress: () {
          if (currentIndex < slides.length - 1) {
            setState(() {
              currentIndex++;
            });
          }
        },
        skipButtonStyle: const ButtonStyle() ,
        doneButtonStyle: ButtonStyle(),
        nextButtonStyle: ButtonStyle(),
        prevButtonStyle: ButtonStyle(),
      ),
    );
  }

  void _navigateToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }
}