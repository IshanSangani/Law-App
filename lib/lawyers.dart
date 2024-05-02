import 'package:flutter/material.dart';
import 'package:law_app/login.dart';
import 'package:law_app/user_pov.dart';
import 'chatbot.dart';
import 'bottom_nav_bar.dart';
import 'petitioner_form.dart';
import 'chat.dart';

class Professional {
  final String name;
  final String category;
  final String photoUrl;
  final double rating;
  final int experienceYears;
  final String contact;

  Professional({
    required this.name,
    required this.category,
    required this.photoUrl,
    required this.rating,
    required this.experienceYears,
    required this.contact,
  });
}

class LawyersListScreen extends StatefulWidget {
  final TextEditingController emailController;

  const LawyersListScreen({Key? key, required this.emailController})
      : super(key: key);

  @override
  _LawyersListScreenState createState() => _LawyersListScreenState();
}

class _LawyersListScreenState extends State<LawyersListScreen> {
  int currentIndex = 0; // Initialize with the desired initial index

  final List<Professional> professionals = [
    Professional(
      name: 'Ishan Sangani',
      category: 'Lawyer',
      photoUrl: 'images/m_lawyer.jpg',
      rating: 4.8,
      experienceYears: 10,
      contact: '+1 123-456-7890',
    ),
    Professional(
      name: 'Prachiti Dahale',
      category: 'Lawyer',
      photoUrl: 'images/f_lawyer.jpg',
      rating: 4.8,
      experienceYears: 8,
      contact: '+1 987-654-3210',
    ),
    Professional(
      name: 'Atharva Dharmadhikari',
      category: 'Lawyer',
      photoUrl: 'images/m_lawyer.jpg',
      rating: 4.8,
      experienceYears: 12,
      contact: '+1 555-123-4567',
    ),
    Professional(
      name: 'Pushpak Deore',
      category: 'Lawyer',
      photoUrl: 'images/m_lawyer.jpg',
      rating: 4.8,
      experienceYears: 15,
      contact: '+1 999-888-7777',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Lawyers'),
        backgroundColor: Colors.blue,
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          )
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer(); // Open the side menu
              },
            );
          },
        ),
        actions: const [
          // ... (other action buttons)
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName:
                  const Text('Your Name'), // Replace with actual user name
              accountEmail: Text(widget.emailController
                  .text), // Replace with email from the controller
              currentAccountPicture: const CircleAvatar(
                backgroundImage: AssetImage(
                    'images/profile_pic.jpeg'), // Replace with actual profile picture
                backgroundColor: Colors.white,
              ),
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                // Navigate to profile screen
              },
            ),
            ListTile(
              leading: const Icon(Icons.folder),
              title: const Text('File Case'), // Add the "Your Filings" option
              onTap: () {
                // Implement your filings screen navigation
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CaseFilingForm(
                            emailController: widget.emailController,
                          )),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.folder),
              title:
                  const Text('Your Filings'), // Add the "Your Filings" option
              onTap: () {
                // Implement your filings screen navigation
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CaseDetailsPage(
                            emailController: widget.emailController,
                          )),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                // Navigate to settings screen
              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Logout'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()),);
              },
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: professionals.length,
        itemBuilder: (context, index) {
          final professional = professionals[index];
          return GestureDetector(
            onTap: () {
              // Navigate to chat page with professional information
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatPage(professional: professional),
                ),
              );
            },
            child: Card(
              elevation: 3,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.transparent,
                  ),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(professional.photoUrl),
                  ),
                  title: Text(professional.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(professional.category),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.yellow),
                          Text('${professional.rating}'),
                        ],
                      ),
                      Text('Experience: ${professional.experienceYears} years'),
                      Text('Contact: ${professional.contact}'),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.chat),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ChatPage(professional: professional),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
          // Handle navigation based on the selected tab
          switch (index) {
            case 0:
              // Navigate to Home screen
              break;
            case 1:
              // Navigate to Settings screen
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ChatBotScreen()),
              );
              break;
            case 3:
              // Navigate to Profile screen
              break;
          }
        },
      ),
    );
  }
}
