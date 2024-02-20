import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dashboard_page.dart'; // Adjust the import based on your project's file structure
import 'forget_password_page.dart';
import 'register_page.dart'; // Ensure this import is correct based on your project structure

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _showSuccessDialog() async {
    return showDialog(
      context: context,
      barrierDismissible: false, // Makes dialog modal
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Login Successful'),
          content: Text('You have been logged in successfully.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss dialog
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => DashboardPage()));
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showErrorDialog(String errorMessage) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Login Failed'),
          content: Text(errorMessage),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        await _showSuccessDialog(); // Show success dialog on successful login
      } on FirebaseAuthException catch (e) {
        String errorMessage = 'Login failed. Please try again.';
        if (e.code == 'user-not-found') {
          errorMessage = 'No user found for that email.';
        } else if (e.code == 'wrong-password') {
          errorMessage = 'Wrong password provided.';
        }
        _showErrorDialog(errorMessage);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.2),
              Image.asset('assets/ic_launcher.png', width: 100, height: 100),
              SizedBox(height: 40),
              TextFormField(
                controller: emailController,
                decoration: _inputDecoration('Email', Icons.email),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  } else if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: _inputDecoration('Password', Icons.lock),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  } else if (value.length < 6) {
                    return 'Password must be at least 6 characters long';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  onPrimary: Colors.white,
                  minimumSize: Size(double.infinity, 50),
                ),
                onPressed: _login,
                child: Text('Log In'),
              ),
              TextButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RegisterPage())),
                child: Text('Don’t have an account? Sign up'),
              ),
              TextButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ForgetPasswordPage())),
                child: Text('Forgot Password?'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      prefixIcon: Icon(icon),
    );
  }
}
