// TODO Implement this library.
import 'package:flutter/material.dart';
import 'job_notification.dart'; // Import JobNotification model

class JobDetailPage extends StatelessWidget {
  final JobNotification notification;

  JobDetailPage({required this.notification});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Job Details'),
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
