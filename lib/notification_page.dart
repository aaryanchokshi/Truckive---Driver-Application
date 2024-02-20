// import 'package:flutter/material.dart';
// import 'dart:async';
// import 'job_details_page.dart';

// // Define a list of example job notifications for demonstration
// final List<JobNotification> jobNotifications = [
//   JobNotification(
//       title: 'New Job Assignment',
//       description:
//           'Deliver goods from Delhi to Mumbai. Expected delivery by 24th March.',
//       date: 'Just now'),
//   JobNotification(
//       title: 'Urgent Delivery Request',
//       description:
//           'Urgent delivery needed from Pune to Hyderabad. High priority task with bonus.',
//       date: '1 hr ago'),
//   JobNotification(
//       title: 'Scheduled Maintenance Reminder',
//       description:
//           'Your truck is due for scheduled maintenance next week. Please plan accordingly.',
//       date: 'Yesterday'),
//   JobNotification(
//       title: 'Long Distance Job Opportunity',
//       description:
//           'Opportunity for a long-distance job from Kolkata to Chennai. High compensation.',
//       date: '2 days ago'),
//   JobNotification(
//       title: 'Document Update Required',
//       description:
//           'Your driving license needs to be updated in our records by the end of this month.',
//       date: '3 days ago'),
//   JobNotification(
//       title: 'Fuel Reimbursement Rate Update',
//       description:
//           'The fuel reimbursement rate has been updated. Check the app for new rates.',
//       date: '1 week ago'),
//   JobNotification(
//       title: 'New Policy Announcement',
//       description:
//           'A new insurance policy for truck drivers has been announced. Details in the app.',
//       date: '1 week ago'),
//   JobNotification(
//       title: 'Holiday Bonus Announced',
//       description:
//           'A special holiday bonus has been announced for all drivers. Happy holidays!',
//       date: '2 weeks ago'),
//   JobNotification(
//       title: 'Safety Gear Upgrade',
//       description:
//           'New safety gear available for drivers. Collect your gear from the office.',
//       date: '3 weeks ago'),
//   JobNotification(
//       title: 'Customer Feedback Reward',
//       description:
//           'Congratulations! You received positive feedback from a customer. Check your reward in the app.',
//       date: '1 month ago'),
// ];

// class NotificationsPage extends StatefulWidget {
//   @override
//   _NotificationsPageState createState() => _NotificationsPageState();
// }

// class _NotificationsPageState extends State<NotificationsPage>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//   late Animation<double> _animation;
//   bool _isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _animationController =
//         AnimationController(vsync: this, duration: Duration(milliseconds: 500));
//     _animation =
//         CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);
//     Timer(Duration(seconds: 2), () {
//       _animationController.forward().then((value) => setState(() {
//             _isLoading = false;
//           }));
//     });
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Notifications'),
//         backgroundColor: Colors.deepPurple,
//       ),
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator())
//           : FadeTransition(
//               opacity: _animation,
//               child: ListView.builder(
//                 itemCount: jobNotifications.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   JobNotification notification = jobNotifications[index];
//                   return Card(
//                     margin: EdgeInsets.all(10),
//                     child: ListTile(
//                       leading:
//                           Icon(Icons.notifications, color: Colors.deepPurple),
//                       title: Text(notification.title),
//                       subtitle: Text(notification.description),
//                       trailing: Text(notification.date,
//                           style: TextStyle(color: Colors.grey, fontSize: 12)),
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) =>
//                                   JobDetailPage(notification: notification)),
//                         );
//                       },
//                     ),
//                   );
//                 },
//               ),
//             ),
//     );
//   }
// }

// // JobDetailPage to display job details
// class JobDetailPage extends StatelessWidget {
//   final JobNotification notification;

//   JobDetailPage({required this.notification});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Job Details'),
//         backgroundColor: Colors.deepPurple,
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(notification.title,
//                 style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
//             SizedBox(height: 10),
//             Text(notification.description, style: TextStyle(fontSize: 16)),
//             SizedBox(height: 20),
//             Text(notification.date,
//                 style: TextStyle(fontSize: 14, color: Colors.grey)),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'dart:async';
import 'job_details_page.dart'; // Ensure this import points to the correct file

// Define a list of example job notifications for demonstration
final List<JobNotification> jobNotifications = [
  JobNotification(
      title: 'New Job Assignment',
      description:
          'Deliver goods from Delhi to Mumbai. Expected delivery by 24th March.',
      date: 'Just now'),
  JobNotification(
      title: 'Urgent Delivery Request',
      description:
          'Urgent delivery needed from Pune to Hyderabad. High priority task with bonus.',
      date: '1 hr ago'),
  JobNotification(
      title: 'Scheduled Maintenance Reminder',
      description:
          'Your truck is due for scheduled maintenance next week. Please plan accordingly.',
      date: 'Yesterday'),
  JobNotification(
      title: 'Long Distance Job Opportunity',
      description:
          'Opportunity for a long-distance job from Kolkata to Chennai. High compensation.',
      date: '2 days ago'),
  JobNotification(
      title: 'Document Update Required',
      description:
          'Your driving license needs to be updated in our records by the end of this month.',
      date: '3 days ago'),
  JobNotification(
      title: 'Fuel Reimbursement Rate Update',
      description:
          'The fuel reimbursement rate has been updated. Check the app for new rates.',
      date: '1 week ago'),
  JobNotification(
      title: 'New Policy Announcement',
      description:
          'A new insurance policy for truck drivers has been announced. Details in the app.',
      date: '1 week ago'),
  JobNotification(
      title: 'Holiday Bonus Announced',
      description:
          'A special holiday bonus has been announced for all drivers. Happy holidays!',
      date: '2 weeks ago'),
  JobNotification(
      title: 'Safety Gear Upgrade',
      description:
          'New safety gear available for drivers. Collect your gear from the office.',
      date: '3 weeks ago'),
  JobNotification(
      title: 'Customer Feedback Reward',
      description:
          'Congratulations! You received positive feedback from a customer. Check your reward in the app.',
      date: '1 month ago'),
];

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);
    Timer(Duration(seconds: 2), () {
      _animationController
          .forward()
          .then((value) => setState(() => _isLoading = false));
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        backgroundColor: Colors.white, // Updated color
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : FadeTransition(
              opacity: _animation,
              child: ListView.builder(
                itemCount: jobNotifications.length,
                itemBuilder: (BuildContext context, int index) {
                  JobNotification notification = jobNotifications[index];
                  return Card(
                    margin: EdgeInsets.all(10),
                    child: ListTile(
                      leading: Icon(Icons.notifications,
                          color: Colors.white), // Adjust icon color if needed
                      title: Text(notification.title),
                      subtitle: Text(notification.description),
                      trailing: Text(notification.date,
                          style: TextStyle(color: Colors.grey, fontSize: 12)),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  JobDetailPage(notification: notification)),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
    );
  }
}
