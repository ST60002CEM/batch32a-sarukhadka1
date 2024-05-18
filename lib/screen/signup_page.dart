import 'package:final_assignment/model/auth_service.dart';
import 'package:final_assignment/model/user_model.dart';
import 'package:final_assignment/screen/login_screen.dart';
import 'package:flutter/material.dart';
 
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});
 
  @override
  _SignUpPageState createState() => _SignUpPageState();
}
 
class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
 
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
 
  bool _isLoading = false;
 
  Future<void> _signUp() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
 
    setState(() {
      _isLoading = true;
    });
 
    var user = UserModel(
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      email: _emailController.text,
      password: _passwordController.text,
      phoneNumber: _phoneController.text,
    );
 
    try {
      await AuthService().signUp(user);
      // Show success dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Sign Up Successful!'),
            content: Text('You have successfully signed up.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  ); // Redirect to login page
                },
              ),
            ],
          );
        },
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign up failed: $error')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(height: 50.0),
            Center(
              child: Image.asset('assets/images/logo.png', height: 150),
            ),
            const SizedBox(height: 20.0),
            const Text(
              "Let's SignUP",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20.0),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  _buildTextField(_firstNameController, 'First Name'),
                  _buildTextField(_lastNameController, 'Last Name'),
                  _buildTextField(_emailController, 'Enter your email below:', TextInputType.emailAddress),
                  _buildPasswordField(_passwordController, 'Password'),
                  _buildPasswordField(_confirmPasswordController, 'Confirm Password'),
                  _buildTextField(_phoneController, 'Phone number', TextInputType.phone),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _signUp,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.deepPurple, // Text color
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      textStyle: const TextStyle(fontSize: 18.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          )
                        : const Text('Sign Up'),
                  ),
                  const SizedBox(height: 20.0),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.deepPurple,
                      textStyle: const TextStyle(decoration: TextDecoration.underline),
                    ),
                    child: const Text('Already have an account? Sign In'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
 
  Widget _buildTextField(TextEditingController controller, String hintText, [TextInputType keyboardType = TextInputType.text]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
          filled: true,
          fillColor: Colors.grey[200],
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $hintText';
          }
          return null;
        },
      ),
    );
  }
 
  Widget _buildPasswordField(TextEditingController controller, String hintText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        obscureText: true,
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
          filled: true,
          fillColor: Colors.grey[200],
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $hintText';
          }
          return null;
        },
      ),
    );
  }
}