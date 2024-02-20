import 'package:flutter/material.dart';

class AccountDetailsPage extends StatefulWidget {
  @override
  _AccountDetailsPageState createState() => _AccountDetailsPageState();
}

class _AccountDetailsPageState extends State<AccountDetailsPage> {
  @override
  Widget build(BuildContext context) {
    // Define your color theme here
    Color primaryColor = Color(0xFF0d2136); // Dark blue color
    Color secondaryColor = Color(0xFF031525); // Even darker blue color
    Color textColor = Colors.white; // For better readability on dark background

    return Scaffold(
      appBar: AppBar(
        title: Text('Account Details'),
        backgroundColor: primaryColor,
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            tileColor: secondaryColor, // Background color of ListTile
            leading: Icon(Icons.person, color: textColor),
            title: Text('Name', style: TextStyle(color: textColor)),
            subtitle: Text('John Doe', style: TextStyle(color: textColor)),
          ),
          ListTile(
            tileColor: secondaryColor, // Background color of ListTile
            leading: Icon(Icons.email, color: textColor),
            title: Text('Email', style: TextStyle(color: textColor)),
            subtitle: Text('john.doe@example.com',
                style: TextStyle(color: textColor)),
          ),
          ListTile(
            tileColor: secondaryColor, // Background color of ListTile
            leading: Icon(Icons.phone, color: textColor),
            title: Text('Phone Number', style: TextStyle(color: textColor)),
            subtitle: Text('+1234567890', style: TextStyle(color: textColor)),
          ),
          ListTile(
            tileColor: secondaryColor, // Background color of ListTile
            leading: Icon(Icons.image, color: textColor),
            title: Text('Profile Picture', style: TextStyle(color: textColor)),
            subtitle: Text('Tap to view', style: TextStyle(color: textColor)),
            onTap: () {
              // Implement navigation to view the profile picture.
            },
          ),
        ],
      ),
    );
  }
}
