import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'court.dart'; // Import your CourtPOV for reference
import 'bottom_nav_bar.dart'; // Import the CustomBottomNavigationBar

class LawyerScreen extends StatefulWidget {
  final TextEditingController emailController;

  const LawyerScreen({Key? key, required this.emailController}) : super(key: key);
  @override
  _LawyerScreenState createState() => _LawyerScreenState();
}

class _LawyerScreenState extends State<LawyerScreen> {
  int _currentIndex = 0; // Initialize currentIndex to 0

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<HearingEvent>> _events = {}; // Mapping dates to hearing events

  @override
  void initState() {
    super.initState();
    // Populate _events map with hearing events for specific dates
    _populateEvents();
  }

  void _populateEvents() {
    // Example: Add hearing events for specific dates
    _events[DateTime.utc(2024, 5, 1)] = [
      HearingEvent(
        'Case 1',
        User('John Doe', '1234567890', 'john@example.com'),
        DateTime.utc(2024, 5, 1, 10, 30),
        EventType.user,
        Priority.high,
        'Civil'
      ),
      HearingEvent(
        'Case 2',
        User('Jane Smith', '9876543210', 'jane@example.com'),
        DateTime.utc(2024, 5, 1, 14, 15),
        EventType.user,
        Priority.medium,
        'Criminal'
      ),
    ];
    _events[DateTime.utc(2024, 5, 5)] = [
      HearingEvent(
        'Case 3',
        User('Emily Johnson', '5551234567', 'emily@example.com'),
        DateTime.utc(2024, 5, 5, 16, 45),
        EventType.user,
        Priority.low,
        'Family'
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lawyer Screen'),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            eventLoader: _getEventsForDay, // Use this callback to load events for each day
          ),
          Expanded(
            child: _buildEventList(),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  // Build the list of hearing events for the selected day
  Widget _buildEventList() {
    if (_selectedDay != null && _events.containsKey(_selectedDay!)) {
      return ListView.builder(
        itemCount: _events[_selectedDay!]!.length,
        itemBuilder: (context, index) {
          final hearingEvent = _events[_selectedDay!]![index];
          Color priorityColor = _getPriorityColor(hearingEvent.priority);
          String priorityText = _getPriorityText(hearingEvent.priority);
          return Card(
            elevation: 3,
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: priorityColor,
                child: _getEventTypeIcon(hearingEvent.type),
                foregroundColor: Colors.white,
              ),
              title: Text('${hearingEvent.caseName} - ${hearingEvent.user.name}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Category: ${hearingEvent.category}'),
                  Text('Priority: $priorityText', style: TextStyle(color: priorityColor)),
                  Text('Date: ${hearingEvent.date.toString()}'),
                  Text('Contact: ${hearingEvent.user.contact}'),
                  Text('Email: ${hearingEvent.user.email}'),
                ],
              ),
              onTap: () {
                // Handle tapping on a hearing event
              },
            ),
          );
        },
      );
    } else {
      return Center(
        child: Text('No events for selected day'),
      );
    }
  }

  // Helper method to get color based on priority
  Color _getPriorityColor(Priority priority) {
    switch (priority) {
      case Priority.high:
        return Colors.red;
      case Priority.medium:
        return Colors.orange;
      case Priority.low:
        return Colors.green;
    }
  }

  // Helper method to get priority text based on priority
  String _getPriorityText(Priority priority) {
    switch (priority) {
      case Priority.high:
        return 'High';
      case Priority.medium:
        return 'Medium';
      case Priority.low:
        return 'Low';
    }
  }

  // Helper method to get icon based on event type
  Icon _getEventTypeIcon(EventType type) {
    return type == EventType.user ? Icon(Icons.person) : Icon(Icons.gavel);
  }

  // Method to load events for each day in the calendar
  List<dynamic> _getEventsForDay(DateTime day) {
    return _events[day] ?? [];
  }
}

// Define the Priority enum
enum Priority { high, medium, low }

// Define the EventType enum
enum EventType { user, court }

// Define the User class
class User {
  final String name;
  final String contact;
  final String email;

  User(this.name, this.contact, this.email);
}

// Define the HearingEvent class
class HearingEvent {
  final String caseName;
  final User user;
  final DateTime date;
  final EventType type;
  final Priority priority;
  final String category;

  HearingEvent(this.caseName, this.user, this.date, this.type, this.priority, this.category);
}
