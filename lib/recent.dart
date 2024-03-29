// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_database/firebase_database.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MaterialApp(home: RecentServicesWidget()));
// }

// class RecentServicesWidget extends StatefulWidget {
//   const RecentServicesWidget({Key? key}) : super(key: key);

//   @override
//   _RecentServicesWidgetState createState() => _RecentServicesWidgetState();
// }

// class _RecentServicesWidgetState extends State<RecentServicesWidget> {
//   final DatabaseReference _servicesRef =
//       FirebaseDatabase.instance.ref('services');

//   @override
//   void initState() {
//     super.initState();
//     // This is where you could load services from Firebase instead of adding them
//     _addServicesToDatabase();
//   }

//   Future<void> _addServicesToDatabase() async {
//     final List<Map<String, dynamic>> services = [
//       {
//         "name": "Oil Change",
//         "description": "Standard oil change service",
//         "image": "https://example.com/oil_change.png",
//         "date": "2024-02-10",
//       },
//       {
//         "name": "Tire Rotation",
//         "description": "Tire rotation to ensure even wear",
//         "image": "https://example.com/tire_rotation.png",
//         "date": "2024-02-15",
//       },
//       {
//         "name": "Battery Check",
//         "description": "Battery health inspection and cleaning",
//         "image": "https://example.com/battery_check.png",
//         "date": "2024-02-20",
//       },
//     ];

//     // Adding services to the database date-wise
//     for (var service in services) {
//       await _servicesRef
//           .child(service['date'].replaceAll('-', ''))
//           .push()
//           .set(service);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Recent Services'),
//         backgroundColor: Colors.blue, // Changed for better visibility
//       ),
//       body: SafeArea(
//         child: ListView.builder(
//           itemCount: 3, // Assuming you want to keep the UI static for now
//           itemBuilder: (context, index) {
//             final service = _servicesRef; // Placeholder for Firebase data
//             return ServiceCard(
//                 service: {}); // Placeholder, as Firebase data fetching is not implemented here
//           },
//         ),
//       ),
//     );
//   }
// }

// class ServiceCard extends StatelessWidget {
//   final Map<String, dynamic> service;

//   const ServiceCard({Key? key, required this.service}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: EdgeInsets.all(8),
//       child: ListTile(
//         leading: CachedNetworkImage(
//           imageUrl: service['image'] ?? '',
//           placeholder: (context, url) =>
//               SpinKitFadingCircle(color: Colors.blue),
//           errorWidget: (context, url, error) =>
//               Icon(Icons.error, color: Colors.red),
//           width: 50,
//           height: 50,
//           fit: BoxFit.cover,
//         ),
//         title: Text(service['name'] ?? 'Service Name'),
//         subtitle: Text(service['description'] ?? 'Service Description'),
//         trailing: Text(service['date'] ?? 'Service Date'),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/services.dart';

class RecentServicesWidget extends StatefulWidget {
  const RecentServicesWidget({Key? key}) : super(key: key);

  @override
  _RecentServicesWidgetState createState() => _RecentServicesWidgetState();
}

class _RecentServicesWidgetState extends State<RecentServicesWidget> {
  // Example static data
  final List<Map<String, dynamic>> _services = [
    {
      "name": "Oil Change",
      "description": "Standard oil change service",
      "image": "https://example.com/oil_change.png",
      "date": "2024-02-10",
    },
    {
      "name": "Tire Rotation",
      "description": "Tire rotation to ensure even wear",
      "image": "https://example.com/tire_rotation.png",
      "date": "2024-02-15",
    },
    {
      "name": "Battery Check",
      "description": "Battery health inspection and cleaning",
      "image": "https://example.com/battery_check.png",
      "date": "2024-02-20",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recent Services'),
        backgroundColor: Colors.white, // Updated AppBar color
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: _services.length,
          itemBuilder: (context, index) {
            final service = _services[index];
            return ServiceCard(service: service);
          },
        ),
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final Map<String, dynamic> service;

  const ServiceCard({Key? key, required this.service}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: ListTile(
        leading: CachedNetworkImage(
          imageUrl: service['image'],
          placeholder: (context, url) => SpinKitFadingCircle(
              color: Colors.black), // Make the spinner white
          errorWidget: (context, url, error) => Icon(Icons.error,
              color: Colors.black), // Make the error icon white
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
        title: Text(service['name']),
        subtitle: Text(service['description']),
        trailing: Text(service['date']),
      ),
    );
  }
}
