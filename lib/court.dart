import 'package:flutter/material.dart';

class CourtPOV extends StatefulWidget {
  @override
  _CourtPOVState createState() => _CourtPOVState();
}

class _CourtPOVState extends State<CourtPOV> {
  // Example list of hearing events
  final List<HearingEvent> hearingEvents = [
    HearingEvent('Case 1', 'John Doe', DateTime(2023, 4, 27, 10, 30), EventType.user, Priority.high, 'Civil'),
    HearingEvent('Case 2', 'Jane Smith', DateTime(2023, 4, 27, 14, 15), EventType.user, Priority.medium, 'Criminal'),
    HearingEvent('Case 3', 'Emily Johnson', DateTime(2023, 4, 27, 16, 45), EventType.user, Priority.low, 'Family'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Court Perspective'),
      ),
      body: ListView.builder(
        itemCount: hearingEvents.length,
        itemBuilder: (context, index) {
          final hearingEvent = hearingEvents[index];
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
              title: Text('${hearingEvent.caseName} - ${hearingEvent.userName}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Category: ${hearingEvent.category}'),
                  Text('Priority: $priorityText', style: TextStyle(color: priorityColor)),
                  Text('Date: ${hearingEvent.date.toString()}'),
                ],
              ),
              onTap: () {
                // Handle tapping on a hearing event
              },
            ),
          );
        },
      ),
    );
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
}

// Define the Priority enum
enum Priority { high, medium, low }

// Define the EventType enum
enum EventType { user, court }

// Define the HearingEvent class
class HearingEvent {
  final String caseName;
  final String userName;
  final DateTime date;
  final EventType type;
  final Priority priority;
  final String category;

  HearingEvent(this.caseName, this.userName, this.date, this.type, this.priority, this.category);
}