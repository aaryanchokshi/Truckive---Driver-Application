import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Truckive Dashboard',
          style: TextStyle(
              color: Colors.white), // Set AppBar title font color to white
        ),
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
                borderRadius: BorderRadius.circular(12),
              ),
              margin: EdgeInsets.all(16),
              width: double.infinity,
              child: Center(
                child: FlutterMap(
                  options: MapOptions(
                    initialCenter: LatLng(23.0261076, 72.5565443),
                    initialZoom: 14,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.app',
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: LatLng(23.0261076, 72.5565443),
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
            ),
          ],
        ),
      ),
      drawer: _buildDrawer(context),
      bottomNavigationBar: _buildBottomAppBar(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Action for FAB
        },
        child: Icon(Icons.map),
        backgroundColor:
            Color(0xFF031525), // Updated FloatingActionButton color
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
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
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text('Driver Name'),
            accountEmail: Text('driver@example.com'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                'D',
                style: TextStyle(fontSize: 40.0),
              ),
            ),
            decoration: BoxDecoration(
              color: Color(0xFF0d2136), // Updated Drawer header color
            ),
          ),
          ListTile(
            leading: Icon(Icons.dashboard),
            title: Text('Dashboard'),
            onTap: () {
              Navigator.pop(context); // Closes the drawer
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
}
