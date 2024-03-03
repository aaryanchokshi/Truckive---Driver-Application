import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class AccountDetailsPage extends StatefulWidget {
  @override
  _AccountDetailsPageState createState() => _AccountDetailsPageState();
}

class _AccountDetailsPageState extends State<AccountDetailsPage> {
  // Define your color theme here
  Color primaryColor = Color(0xFF0d2136); // Dark blue color
  Color secondaryColor = Color(0xFF031525); // Even darker blue color
  Color textColor = Colors.white; // For better readability on dark background

  late DatabaseReference _accountDetailsRef;

  Map<String, dynamic> accountDetails = {
    'name': '',
    'email': '',
    'phoneNumber': '',
    'profilePicture': 'Tap to view', // Placeholder for profile picture
  };

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().then((value) {
      _accountDetailsRef =
          FirebaseDatabase.instance.reference().child('accountDetails');
      _fetchAccountDetailsFromFirebase();
    });
  }

  Future<void> _fetchAccountDetailsFromFirebase() async {
    _accountDetailsRef.once().then((DatabaseEvent event) {
      final snapshot = event.snapshot;
      if (snapshot.value != null) {
        // Ensure the data is a Map before attempting to cast
        final data = snapshot.value as Map<dynamic, dynamic>;
        // Convert dynamic map to a <String, dynamic> map
        final accountDetailsMap = data.map(
            (key, value) => MapEntry<String, dynamic>(key.toString(), value));
        setState(() {
          accountDetails = accountDetailsMap;
        });
      }
    }).catchError((error) {
      print('Error fetching account details from Firebase: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account Details'),
        backgroundColor: primaryColor,
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            tileColor: secondaryColor,
            leading: Icon(Icons.person, color: textColor),
            title: Text('Name', style: TextStyle(color: textColor)),
            subtitle: Text(accountDetails['name'],
                style: TextStyle(color: textColor)),
          ),
          ListTile(
            tileColor: secondaryColor,
            leading: Icon(Icons.email, color: textColor),
            title: Text('Email', style: TextStyle(color: textColor)),
            subtitle: Text(accountDetails['email'],
                style: TextStyle(color: textColor)),
          ),
          ListTile(
            tileColor: secondaryColor,
            leading: Icon(Icons.phone, color: textColor),
            title: Text('Phone Number', style: TextStyle(color: textColor)),
            subtitle: Text(accountDetails['phoneNumber'],
                style: TextStyle(color: textColor)),
          ),
          ListTile(
            tileColor: secondaryColor,
            leading: Icon(Icons.image, color: textColor),
            title: Text('Profile Picture', style: TextStyle(color: textColor)),
            subtitle: Text(accountDetails['profilePicture'],
                style: TextStyle(color: textColor)),
            onTap: () {
              // Implement navigation to view the profile picture.
            },
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// class AccountDetailsPage extends StatefulWidget {
//   @override
//   _AccountDetailsPageState createState() => _AccountDetailsPageState();
// }

// class _AccountDetailsPageState extends State<AccountDetailsPage> {
//   @override
//   Widget build(BuildContext context) {
//     // Define your color theme here
//     Color primaryColor = Color(0xFF0d2136); // Dark blue color
//     Color secondaryColor = Color(0xFF031525); // Even darker blue color
//     Color textColor = Colors.white; // For better readability on dark background

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Account Details'),
//         backgroundColor: primaryColor,
//       ),
//       body: ListView(
//         children: <Widget>[
//           ListTile(
//             tileColor: secondaryColor, // Background color of ListTile
//             leading: Icon(Icons.person, color: textColor),
//             title: Text('Name', style: TextStyle(color: textColor)),
//             subtitle: Text('John Doe', style: TextStyle(color: textColor)),
//           ),
//           ListTile(
//             tileColor: secondaryColor, // Background color of ListTile
//             leading: Icon(Icons.email, color: textColor),
//             title: Text('Email', style: TextStyle(color: textColor)),
//             subtitle: Text('john.doe@example.com',
//                 style: TextStyle(color: textColor)),
//           ),
//           ListTile(
//             tileColor: secondaryColor, // Background color of ListTile
//             leading: Icon(Icons.phone, color: textColor),
//             title: Text('Phone Number', style: TextStyle(color: textColor)),
//             subtitle: Text('+1234567890', style: TextStyle(color: textColor)),
//           ),
//           ListTile(
//             tileColor: secondaryColor, // Background color of ListTile
//             leading: Icon(Icons.image, color: textColor),
//             title: Text('Profile Picture', style: TextStyle(color: textColor)),
//             subtitle: Text('Tap to view', style: TextStyle(color: textColor)),
//             onTap: () {
//               // Implement navigation to view the profile picture.
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
