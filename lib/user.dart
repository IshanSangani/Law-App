import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lawyer Consultation App',
      theme: ThemeData(
        primaryColor: Colors.blueGrey[800],
        scaffoldBackgroundColor: Colors.grey[200],
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blueGrey[800],
        ),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blueGrey,
          accentColor: Colors.blueAccent,
          backgroundColor: Colors.grey[200],
          errorColor: Colors.red,
          brightness: Brightness.light,
        ),
      ),
      home: const MyHomePage(title: 'Lawyer Consultation Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
   final List<Map<String, dynamic>> _lawyers = [
    {
      'name': 'Rajesh Sharma',
      'specialization': 'Criminal Defense',
      'experience': '8 Years',
      'hourlyRate': '₹200/min',
    },
    {
      'name': 'Priya Patel',
      'specialization': 'Family Law',
      'experience': '6 Years',
      'hourlyRate': '₹150/min',
    },
    {
      'name': 'Vikram Singh',
      'specialization': 'Personal Injury',
      'experience': '10 Years',
      'hourlyRate': '₹250/min',
    },
    {
      'name': 'Aisha Khan',
      'specialization': 'Real Estate Law',
      'experience': '5 Years',
      'hourlyRate': '₹180/min',
    },
    {
      'name': 'Neha Gupta',
      'specialization': 'Corporate Law',
      'experience': '7 Years',
      'hourlyRate': '₹220/min',
    },
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueGrey[800],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.account_circle,
                      size: 40,
                      color: Colors.blueGrey[800],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'John Doe', // Update with user's name or remove
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  const Text(
                    'Lawyer', // Update with user's role or remove
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: const Text('Add Lawyer'), // Updated drawer item
              onTap: () {
                _showAddLawyerDialog(context); // Implement functionality
              },
            ),
            ListTile(
              title: const Text('Lawyer List'), // Updated drawer item
              onTap: () {
                // Implement functionality
              },
            ),
          ],
        ),
      ),
      body: _selectedIndex == 0
          ? const HomeScreen()
          : ListView.builder(
        itemCount: _lawyers.length,
        itemBuilder: (context, index) {
          return _buildLawyerCard(_lawyers[index]);
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.call),
            label: 'Call',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueGrey[800],
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildLawyerCard(Map<String, dynamic> lawyerData) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      elevation: 5,
      child: ListTile(
        leading: CircleAvatar(
          // Use lawyer's profile picture if available
          backgroundColor: Colors.grey[300],
          child: Icon(
            Icons.account_circle,
            color: Colors.blueGrey[800],
          ),
        ),
        title: Text(lawyerData['name']),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(lawyerData['specialization']),
            Text('Experience: ${lawyerData['experience']}'),
            Text('Hourly Rate: ${lawyerData['hourlyRate']}'),
          ],
        ),
        trailing: ElevatedButton(
          onPressed: () {
            // Implement consultation functionality
          },
          child: const Text('Consult'),
        ),
      ),
    );
  }

  void _showAddLawyerDialog(BuildContext context) {
    // Implement functionality to add a lawyer
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Current Status:', // Updated section title
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          // Add your current status widget here
          const SizedBox(height: 20),
          const Text(
            'Next Court Date: 25th April 2024',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 10),
          const Text(
            'Case Details:',
            style: TextStyle(fontSize: 16),
          ),
          const Text(
            'The plaintiff, John Smith, is suing the defendant, Jane Jones, for damages resulting from a car accident.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              // Implement functionality
            },
            child: const Text('View Documents'),
          ),
        ],
      ),
    );
  }
}
