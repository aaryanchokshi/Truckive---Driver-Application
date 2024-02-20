import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'login_page.dart'; // Adjust this import based on your project structure

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final success = await _createUser(email, password);

    if (success) {
      _showSuccessDialog();
    }
  }

  Future<bool> _createUser(String email, String password) async {
    try {
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _saveUserDetails(userCredential.user!);
      return true;
    } catch (e) {
      _handleAuthError(e);
      return false;
    }
  }

  Future<void> _saveUserDetails(User user) async {
    final uid = user.uid;
    final userData = {
      'fullName': _nameController.text.trim(),
      'email': user.email,
      'phoneNumber': _phoneController.text.trim(),
    };
    await FirebaseDatabase.instance
        .reference()
        .child('users')
        .child(uid)
        .set(userData);
  }

  void _handleAuthError(dynamic e) {
    String errorMessage = "An unexpected error occurred.";
    if (e is FirebaseAuthException) {
      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'An account already exists for that email.';
      }
    }
    _showErrorDialog(errorMessage);
  }

  Future<void> _showSuccessDialog() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Registration Successful'),
        content: const Text('Your account has been created successfully.'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.popUntil(context, ModalRoute.withName('/'));
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const LoginPage()));
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _showErrorDialog(String errorMessage) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Registration Failed'),
        content: Text(errorMessage),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height * 0.15),
              Image.asset('assets/ic_launcher.png', width: 100, height: 100),
              const SizedBox(height: 40),
              ..._buildTextFields(),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: _register,
                child: const Text('Sign Up'),
              ),
              TextButton(
                onPressed: () => Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const LoginPage())),
                child: const Text('Already have an account? Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildTextFields() {
    return [
      _buildTextField(_nameController, 'Full Name', Icons.person),
      const SizedBox(height: 20),
      _buildTextField(_emailController, 'Email', Icons.email, isEmail: true),
      const SizedBox(height: 20),
      _buildTextField(_phoneController, 'Phone Number', Icons.phone),
      const SizedBox(height: 20),
      _buildTextField(_passwordController, 'Password', Icons.lock,
          isPassword: true),
    ];
  }

  Widget _buildTextField(
      TextEditingController controller, String label, IconData icon,
      {bool isPassword = false, bool isEmail = false}) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: isEmail
          ? TextInputType.emailAddress
          : (label == 'Phone Number'
              ? TextInputType.phone
              : TextInputType.text),
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        prefixIcon: Icon(icon),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your $label';
        } else if (isEmail && !RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
          return 'Please enter a valid email';
        } else if (isPassword && value.length < 6) {
          return 'Password must be at least 6 characters long';
        }
        return null;
      },
    );
  }
}
