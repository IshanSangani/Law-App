import 'package:flutter/material.dart';
import 'chatbot.dart';
import 'bottom_nav_bar.dart';

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
  @override
  _LawyersListScreenState createState() => _LawyersListScreenState();
}

class _LawyersListScreenState extends State<LawyersListScreen> {
  int currentIndex = 0; // Initialize with the desired initial index

  final List<Professional> professionals = [
    Professional(
      name: 'Ishan Sangani',
      category: 'Lawyer',
      photoUrl: 'assets/john_doe.jpg',
      rating: 4.8,
      experienceYears: 10,
      contact: '+1 123-456-7890',
    ),
    Professional(
      name: 'Prachiti Dahale',
      category: 'Lawyer',
      photoUrl: 'assets/john_doe.jpg',
      rating: 4.8,
      experienceYears: 8,
      contact: '+1 987-654-3210',
    ),
    Professional(
      name: 'Atharva Dharmadhikari',
      category: 'Lawyer',
      photoUrl: 'assets/john_doe.jpg',
      rating: 4.8,
      experienceYears: 12,
      contact: '+1 555-123-4567',
    ),
    Professional(
      name: 'Pushpak Deore',
      category: 'Lawyer',
      photoUrl: 'assets/john_doe.jpg',
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
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu), // Hamburger menu icon
              onPressed: () {
                // Open the side menu (drawer) or perform any other action
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // Show filter options
            },
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Implement search functionality
            },
            style: const ButtonStyle(),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: professionals.length,
        itemBuilder: (context, index) {
          final professional = professionals[index];
          return Card(
            elevation: 3,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                    color:
                        Colors.transparent), // Set border color to transparent
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
                onTap: () {
                  // Handle professional selection (e.g., navigate to details screen)
                },
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
