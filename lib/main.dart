import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:truck_driver_app/setting_page.dart'; // Ensure this path matches your project structure
import 'dashboard_page.dart'; // Ensure this path matches your project structure
import 'edit_profile_widget.dart'; // Ensure this path matches your project structure
import 'help_support_page.dart'; // Ensure this path matches your project structure
import 'login_page.dart'; // Ensure this path matches your project structure
import 'notification_page.dart'; // Ensure this path matches your project structure
import 'payments_page.dart';
import 'register_page.dart'; // Ensure this path matches your project structure
import 'recent.dart'; // Ensure this path matches your project structure
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // Ensure this file is correctly created with your Firebase options

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await requestPermissions();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions
        .currentPlatform, // Ensure this matches your Firebase configuration
  );
  runApp(MyApp());
}

Future<void> requestPermissions() async {
  await [Permission.location, Permission.sms, Permission.phone].request();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Truck Driver App',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: Colors.black,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.black,
          secondary: Colors.yellowAccent,
        ),
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/dashboard': (context) => DashboardPage(),
        '/notification': (context) => NotificationsPage(),
        '/editProfile': (context) => EditProfileWidget(),
        '/helpSupport': (context) => HelpSupportPage(),
        '/payments': (context) => PaymentPage(),
        '/recent': (context) =>
            RecentServicesWidget(), // Ensure this widget is defined in your recent.dart
        '/settings': (context) =>
            SettingsPage(), // Ensure SettingsPage is defined in your setting_page.dart
      },
    );
  }
}
