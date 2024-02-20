import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:truck_driver_app/driving_preference_page.dart';
import 'account_details_page.dart'; // Make sure to create this file
import 'driving_preferences_page.dart'; // Make sure to create this file
import 'accessibility_page.dart'; // Make sure to create this file
import 'login_page.dart'; // Make sure you have this page created

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    // Define your color theme here
    Color primaryColor = Color(0xFF0d2136);
    Color secondaryColor = Color(0xFF031525);

    return Theme(
      data: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          brightness: Brightness.dark,
          primary: primaryColor,
          secondary: secondaryColor,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: primaryColor,
          titleTextStyle: TextStyle(color: Colors.white),
        ),
        switchTheme: SwitchThemeData(
          thumbColor: MaterialStateProperty.all(Colors.white),
          trackColor: MaterialStateProperty.all(secondaryColor),
        ),
        listTileTheme: ListTileThemeData(
          iconColor: Colors.white,
          textColor: Colors.white,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
        ),
        body: ListView(
          children: <Widget>[
            SwitchListTile(
              title: Text('Enable Notifications'),
              value: _notificationsEnabled,
              onChanged: (bool value) {
                setState(() {
                  _notificationsEnabled = value;
                });
              },
            ),
            SwitchListTile(
              title: Text('Enable Dark Mode'),
              value: _darkModeEnabled,
              onChanged: (bool value) {
                setState(() {
                  _darkModeEnabled = value;
                });
              },
            ),
            ListTile(
              title: Text('Account Details'),
              leading: Icon(Icons.person),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AccountDetailsPage()));
              },
            ),
            ListTile(
              title: Text('Driving Preferences'),
              leading: Icon(Icons.drive_eta),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DrivingPreferencesPage()));
              },
            ),
            ListTile(
              title: Text('Accessibility'),
              leading: Icon(Icons.accessibility),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AccessibilityPage()));
              },
            ),
            ListTile(
              title: Text('Sign Out'),
              leading: Icon(Icons.exit_to_app),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
