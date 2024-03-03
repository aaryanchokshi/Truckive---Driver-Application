// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class EditProfileWidget extends StatefulWidget {
//   const EditProfileWidget({Key? key}) : super(key: key);

//   @override
//   _EditProfileWidgetState createState() => _EditProfileWidgetState();
// }

// class _EditProfileWidgetState extends State<EditProfileWidget> {
//   final scaffoldKey = GlobalKey<ScaffoldState>();
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _bioController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     // Mock Data for demonstration
//     _nameController.text = 'John Doe';
//     _emailController.text = 'john.doe@example.com';
//     _bioController.text = 'Truck driver with 5 years of experience.';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: scaffoldKey,
//       appBar: AppBar(
//         backgroundColor: Colors.deepPurple,
//         automaticallyImplyLeading: true,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back_rounded),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: Text('Edit Profile'),
//         centerTitle: true,
//         elevation: 0,
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: EdgeInsets.symmetric(horizontal: 16),
//           child: Column(
//             children: [
//               SizedBox(height: 24),
//               CircleAvatar(
//                 radius: 50,
//                 backgroundImage:
//                     NetworkImage('https://via.placeholder.com/150'),
//                 backgroundColor: Colors.grey[300],
//               ),
//               SizedBox(height: 16),
//               TextButton(
//                 onPressed: () {
//                   // Function to change photo
//                 },
//                 child:
//                     Text('Change Photo', style: TextStyle(color: Colors.blue)),
//               ),
//               SizedBox(height: 24),
//               TextFormField(
//                 controller: _nameController,
//                 decoration: InputDecoration(
//                   labelText: 'Full Name',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               SizedBox(height: 16),
//               TextFormField(
//                 controller: _emailController,
//                 decoration: InputDecoration(
//                   labelText: 'Email Address',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               SizedBox(height: 16),
//               TextFormField(
//                 controller: _bioController,
//                 decoration: InputDecoration(
//                   labelText: 'Bio',
//                   border: OutlineInputBorder(),
//                 ),
//                 maxLines: null,
//               ),
//               SizedBox(height: 24),
//               ElevatedButton(
//                 onPressed: () {
//                   // Function to save changes
//                 },
//                 child: Text('Save Changes'),
//                 style: ElevatedButton.styleFrom(
//                   primary: Colors.deepPurple,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                   padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class EditProfileWidget extends StatefulWidget {
  const EditProfileWidget({Key? key}) : super(key: key);

  @override
  _EditProfileWidgetState createState() => _EditProfileWidgetState();
}

class _EditProfileWidgetState extends State<EditProfileWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = 'John Doe';
    _emailController.text = 'john.doe@example.com';
    _bioController.text = 'Truck driver with 5 years of experience.';
  }

  Future<void> _saveProfileChanges() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DatabaseReference dbRef =
          FirebaseDatabase.instance.ref('userProfiles/${user.uid}');
      await dbRef.set({
        'name': _nameController.text,
        'email': _emailController.text,
        'bio': _bioController.text,
      }).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Profile updated successfully!'),
        ));
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error updating profile: $error'),
        ));
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('No user logged in.'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Edit Profile', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(height: 24),
              CircleAvatar(
                radius: 50,
                backgroundImage:
                    NetworkImage('https://via.placeholder.com/150'),
                backgroundColor: Colors.grey[300],
              ),
              SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  // Function to change photo
                },
                child:
                    Text('Change Photo', style: TextStyle(color: Colors.blue)),
              ),
              SizedBox(height: 24),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email Address',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _bioController,
                decoration: InputDecoration(
                  labelText: 'Bio',
                  border: OutlineInputBorder(),
                ),
                maxLines: null,
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saveProfileChanges,
                child: Text('Save Changes'),
                style: ElevatedButton.styleFrom(
                  primary: Colors
                      .white, // You might want to change the color to match your theme
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
