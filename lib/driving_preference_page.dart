import 'package:flutter/material.dart';

class DrivingPreferencesPage extends StatefulWidget {
  @override
  _DrivingPreferencesPageState createState() => _DrivingPreferencesPageState();
}

class _DrivingPreferencesPageState extends State<DrivingPreferencesPage> {
  bool allowPets = false;
  bool longDistanceRides = true;

  @override
  Widget build(BuildContext context) {
    // Define your color theme here
    Color primaryColor = Color(0xFF0d2136); // Dark blue color
    Color secondaryColor = Color(0xFF031525); // Even darker blue color

    return Scaffold(
      appBar: AppBar(
        title: Text('Driving Preferences'),
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            Card(
              color: secondaryColor, // Card color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: SwitchListTile(
                title:
                    Text('Allow Pets', style: TextStyle(color: Colors.white)),
                secondary: Icon(Icons.pets, color: Colors.white),
                value: allowPets,
                onChanged: (bool value) {
                  setState(() {
                    allowPets = value;
                  });
                },
                activeColor: Colors.white,
                activeTrackColor: Colors
                    .green, // Use a color that stands out for the active state
              ),
            ),
            Card(
              color: secondaryColor, // Card color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: SwitchListTile(
                title: Text('Long Distance Rides',
                    style: TextStyle(color: Colors.white)),
                secondary: Icon(Icons.route, color: Colors.white),
                value: longDistanceRides,
                onChanged: (bool value) {
                  setState(() {
                    longDistanceRides = value;
                  });
                },
                activeColor: Colors.white,
                activeTrackColor: Colors
                    .green, // Use a color that stands out for the active state
              ),
            ),
          ],
        ),
      ),
    );
  }
}
