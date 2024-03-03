// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:latlong2/latlong.dart';

// class DashboardPage extends StatelessWidget {
//   final MapController _mapController = MapController();
//   Future<void> _centerMapOnCurrentLocation() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     // Test if location services are enabled.
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       // Location services are not enabled. Don't continue
//       // accessing the position and inform the user.
//       return Future.error('Location services are disabled.');
//     }

//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         // Permissions are denied, don't continue
//         // accessing the position and inform the user.
//         return Future.error('Location permissions are denied');
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       // Permissions are permanently denied, don't continue
//       // accessing the position and inform the user.
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }

//     // When permissions are granted, continue accessing the position
//     Position position = await Geolocator.getCurrentPosition();
//     _mapController.move(LatLng(position.latitude, position.longitude), 15);
//   }

// ignore_for_file: deprecated_member_use

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Truckive Dashboard',
//           style: TextStyle(
//               color: Colors.white), // Set AppBar title font color to white
//         ),
//         backgroundColor: Color(0xFF0d2136),
//         iconTheme: IconThemeData(color: Colors.white), // Updated AppBar color
//         actions: [
//           IconButton(
//             color: Colors.white,
//             icon: Icon(Icons.notifications),
//             onPressed: () {
//               Navigator.pushNamed(context, '/notification');
//             },
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               height: MediaQuery.of(context).size.height -
//                   AppBar().preferredSize.height -
//                   56,
//               decoration: BoxDecoration(
//                 color: Colors.grey[300],
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               margin: EdgeInsets.all(16),
//               width: double.infinity,
//               child: Center(
//                 child: FlutterMap(
//                   options: MapOptions(
//                     initialCenter: LatLng(23.0261076, 72.5565443),
//                     initialZoom: 14,
//                   ),
//                   children: [
//                     TileLayer(
//                       urlTemplate:
//                           'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
//                       userAgentPackageName: 'com.example.app',
//                     ),
//                     MarkerLayer(
//                       markers: [
//                         Marker(
//                           point: LatLng(23.0261076, 72.5565443),
//                           width: 80,
//                           height: 80,
//                           child: Image.network(
//                             'https://cdn-icons-png.flaticon.com/512/2344/2344094.png',
//                             width: 20,
//                             height: 20,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DashboardPage(),
    );
  }
}

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final MapController _mapController = MapController();
  LatLng _currentLocation = LatLng(0, 0);
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _determinePosition();
    _startLocationUpdateTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _determinePosition() async {
    // Similar implementation as before
    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
    });
    _mapController.move(_currentLocation, 15);
  }

  void _startLocationUpdateTimer() {
    const duration = Duration(minutes: 5);
    _timer = Timer.periodic(duration, (Timer timer) async {
      Position position = await Geolocator.getCurrentPosition();
      _updateLocationInFirebase(position);
    });
  }

  void _updateLocationInFirebase(Position position) async {
    // Get the current user from Firebase Auth
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print("User is not logged in.");
      return; // Exit if there is no logged-in user
    }

    // Use the user's UID as the key in the database reference
    final DatabaseReference dbRef =
        FirebaseDatabase.instance.ref("driverLocation/${user.uid}");

    // Get the driver's name; default to "Unknown" if not available
    String driverName = user.displayName ?? "Unknown";

    // Include the driver's name and location data in Firebase
    dbRef.set({
      "name": driverName,
      "latitude": position.latitude,
      "longitude": position.longitude,
      "timestamp": DateTime.now().toIso8601String(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Truckive Dashboard', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF0d2136),
        iconTheme: IconThemeData(color: Colors.white), // Updated AppBar color
        actions: [
          IconButton(
            color: Colors.white,
            icon: Icon(Icons.notifications),
            onPressed: () {
              Navigator.pushNamed(context, '/notification');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height -
                  AppBar().preferredSize.height -
                  56,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(12)),
              margin: EdgeInsets.all(16),
              child: FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  center: _currentLocation, // Correct the typo here
                  zoom: 14,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: ['a', 'b', 'c'],
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: _currentLocation,
                        width: 80,
                        height: 80,
                        child: Image.network(
                          'https://cdn-icons-png.flaticon.com/512/2344/2344094.png',
                          width: 20,
                          height: 20,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:
            _determinePosition, // This will recenter the map to the current location
        child: Icon(Icons.my_location),
        backgroundColor: Color(0xFF031525),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildBottomAppBar(context),
      drawer: _buildDrawer(context),
    );
  }
}

Widget _buildBottomAppBar(BuildContext context) {
  return BottomAppBar(
    shape: CircularNotchedRectangle(),
    notchMargin: 6.0,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.dashboard),
          onPressed: () {
            // Navigate to Dashboard
          },
        ),
        IconButton(
          icon: Icon(Icons.monetization_on),
          onPressed: () {
            // Placeholder for Earnings action
            Navigator.pushNamed(context, '/payments');
          },
        ),
        SizedBox(width: 48), // The middle space for the FAB
        IconButton(
          icon: Icon(Icons.history),
          onPressed: () {
            Navigator.pushNamed(context, '/recent');
          },
        ),
        IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {
            Navigator.pushNamed(context, '/settings');
          },
        ),
      ],
    ),
  );
}

Widget _buildDrawer(BuildContext context) {
  // Access the current user
  final user = FirebaseAuth.instance.currentUser;

  // Use the user's display name and email, with fallbacks in case they're null
  final String driverEmail = user?.email ?? 'driver@example.com';

  return Drawer(
    child: ListView(
      children: <Widget>[
        UserAccountsDrawerHeader(
          // Since you're not displaying the driver's name, you might want to use a static text like "Driver Account" or similar
          accountName: Text(
              'Driver Account'), // Static text or you can remove this if you don't want a name displayed
          accountEmail: Text(driverEmail), // Display the driver's email
          currentAccountPicture: CircleAvatar(
            backgroundColor: Colors.white,
            child: Text(
              driverEmail.isNotEmpty
                  ? driverEmail[0].toUpperCase()
                  : 'D', // Use the first letter of the email, or 'D' as a fallback
              style: TextStyle(fontSize: 40.0),
            ),
          ),
          decoration: BoxDecoration(
            color: Color(0xFF0d2136), // Drawer header color
          ),
        ),
        ListTile(
          leading: Icon(Icons.dashboard),
          title: Text('Dashboard'),
          onTap: () {
            Navigator.pop(context);
            // Closes the drawer
          },
        ),
        ListTile(
          leading: Icon(Icons.edit),
          title: Text('Edit Profile'),
          onTap: () {
            Navigator.pop(context); // Close the drawer
            Navigator.pushNamed(context, '/editProfile');
          },
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text('Settings'),
          onTap: () {
            Navigator.pop(context); // Close the drawer
            Navigator.pushNamed(context, '/settings');
          },
        ),
        ListTile(
          leading: Icon(Icons.help_outline),
          title: Text('Help & Support'),
          onTap: () {
            Navigator.pop(context); // Close the drawer
            Navigator.pushNamed(context, '/helpSupport');
          },
        ),
        // Additional drawer items can be added here following the same pattern
      ],
    ),
  );
}
