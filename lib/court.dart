import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart'; // Import the intl package
import 'config.dart';

class CourtPOV extends StatefulWidget {
  @override
  _CourtPOVState createState() => _CourtPOVState();
}

class _CourtPOVState extends State<CourtPOV> {
  List<HearingEvent> hearingEvents = [];

  @override
  void initState() {
    super.initState();
    fetchHearingEvents();
  }

  Future<void> fetchHearingEvents() async {
    try {
      final response = await http.post(Uri.parse(getcaselistUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List<dynamic> successData = data['success'];
        setState(() {
          hearingEvents = successData
              .map((event) => HearingEvent(
                  event['caseType'],
                  event['petitionerName'],
                  DateTime.parse(event['hearingDate']),
                  getPriorityFromString(event['priority'])))
              .toList();
        });
      } else {
        throw Exception('Failed to fetch hearing events');
      }
    } catch (error) {
      print('Error fetching hearing events: $error');
    }
  }

  Priority getPriorityFromString(String priority) {
    switch (priority) {
      case 'High':
        return Priority.high;
      case 'Medium':
        return Priority.medium;
      case 'Low':
        return Priority.low;
      default:
        return Priority.low;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Court Perspective'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: fetchHearingEvents,
          ),
        ],
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
              title: Text('Case Type: ${hearingEvent.caseType}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Priority: $priorityText',
                      style: TextStyle(color: priorityColor)),
                  Text('Petitioner Name: ${hearingEvent.petitionerName}'),
                  Text(
                      'Hearing Date: ${DateFormat('yyyy-MM-dd').format(hearingEvent.date)}'), // Use DateFormat here
                ],
              ),
            ),
          );
        },
      ),
    );
  }

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
}

class HearingEvent {
  final String caseType;
  final String petitionerName;
  final DateTime date;
  final Priority priority;

  HearingEvent(this.caseType, this.petitionerName, this.date, this.priority);
}

enum Priority { high, medium, low }
