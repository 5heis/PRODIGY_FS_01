import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prodigy_fs_01/pages/auth_page.dart';
import 'package:prodigy_fs_01/pages/login.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Text editing controllers
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final confirmpasswordcontroller = TextEditingController();

  // Form key
  final _formKey = GlobalKey<FormState>();

  // Sign User up
  void signup() async {
    // Show loading circle
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(color: Colors.green),
      ),
    );

    

    // Make sure passwords match
    if (passwordcontroller.text != confirmpasswordcontroller.text) {
      // Pop loading circle
      Navigator.pop(context);
      // Show error to user
      displayMessage("Passwords don't match!");
      return;
    }

    try {
      // Create user
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailcontroller.text,
        password: passwordcontroller.text,
      );
          

      // Pop loading circle
      if (context.mounted) Navigator.pop(context);

      // Show success message 
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Account Created'),
            content: Text(
              'Account created successfully.'
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AuthPage(),
                    ),
                  );
                },
                child: Text('Ok'),
              ),
            ],
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      // Pop loading circle
      Navigator.pop(context);

      // Display error message to user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 2),
          backgroundColor: Colors.grey[900],
          content: Row(
            children: [
              Icon(
                Icons.error,
                color: Colors.red,
                size: 40,
              ),
              SizedBox(
                width: 50,
              ),
              Text(
                e.code,
                style: TextStyle(color: Colors.grey[100]),
              ),
            ],
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (e) {
      // Pop loading circle
      Navigator.pop(context);

      // Display error message to user
      print('Error: $e');
      displayMessage('Failed to create account. Please try again later.');
    }
    
  }

  // Display dialogue message
  void displayMessage(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.red,
        title: Text(message, style: TextStyle(color: Colors.white),),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenwidth = MediaQuery.of(context).size.width;
    final maxContainerWidth = 450.0;
    
    return Scaffold(
      
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SafeArea(
            child: Center(
              child: Column(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    }, 
                    icon: Icon(Icons.close)
                  ),
                  SizedBox(height: 40,),
                  Container(
                    width: screenwidth < maxContainerWidth ? screenwidth : maxContainerWidth,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green),
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey[100],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 20),
                  
                          // CTA Text
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(width: 12),
                              Text(
                                "Lets set up your profile",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 26,
                                  color: Colors.black
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                  
                          // Email textfield
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: emailcontroller,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                                borderSide: BorderSide.none,
                              ),
                              fillColor: Colors.white,
                              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              filled: true,
                              hintText: 'Email',
                              hintStyle: TextStyle(color: Colors.grey[500]),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty || !RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                          ),
                  
                          const SizedBox(height: 15),
                  
                          // Password textfield
                          TextFormField(
                            controller: passwordcontroller,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                                borderSide: BorderSide.none,
                              ),
                              fillColor: Colors.white,
                              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              filled: true,
                              hintText: 'Password',
                              hintStyle: TextStyle(color: Colors.grey[500]),
                            ),
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                          ),
                  
                          const SizedBox(height: 15),
                  
                          // Confirm Password textfield
                          TextFormField(
                            controller: confirmpasswordcontroller,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                                borderSide: BorderSide.none,
                              ),
                              fillColor: Colors.white,
                              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              filled: true,
                              hintText: 'Confirm Password',
                              hintStyle: TextStyle(color: Colors.grey[500]),
                            ),
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please confirm your password';
                              }
                              if (value != passwordcontroller.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          // Register button
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  signup();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(300, 50),
                                foregroundColor: Colors.black,
                                backgroundColor: Colors.green,
                              ),
                              child: Text('Create Account', style: TextStyle(fontSize: 25)),
                            ),
                          ),
                  
                          const SizedBox(height: 25),
                  
                          // Sign in
                          Padding(
                            padding: const EdgeInsets.only(left: 25),
                            child: Row(
                              children: [
                                Text(
                                  'Already a member?',
                                  style: TextStyle(color: Colors.black),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return const LoginPage();
                                        },
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Login',
                                    style: TextStyle(color: Colors.lightBlue),
                                  ),
                                ),
                              ],
                            ),
                          ), 
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
