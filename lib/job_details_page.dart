import 'package:flutter/material.dart';

// Assuming JobNotification is defined in the same file as NotificationsPage or elsewhere
// If not, include the JobNotification class definition here as well
// Define the JobNotification model if it's not already defined
class JobNotification {
  final String title;
  final String description;
  final String date;

  JobNotification(
      {required this.title, required this.description, required this.date});
}

class JobDetailPage extends StatelessWidget {
  final JobNotification notification;

  JobDetailPage({required this.notification});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Job Details'),
        backgroundColor: Color(0xFF0d2136), // Updated color
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(notification.title,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text(notification.description, style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Text(notification.date,
                style: TextStyle(fontSize: 14, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
