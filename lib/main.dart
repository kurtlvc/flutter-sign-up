/**
 * Repository
 * https://github.com/kurtlvc/flutter-sign-up
 * 
 * Github Pages Preview
 * https://kurtlvc.github.io/flutter-sign-up/
 * 
 * Sign-up screen design flutter application for ITP107 - Mobile Application Development
 * 7 Different Flutter Widgets:
 * 1. Text Field - Username, Email and Password
 * 2. Image - Binbows from https://www.deviantart.com/goukai/art/Michaelsoft-Binbows-176728443
 * 3. Dropdown - Region Selection
 * 4. Container - Padding and Styling
 * 5. Card - Outlined Card for Form
 * 6. Elevated Button - Submit Button
 * 7. Gesture Detector - Detects Double Tap and Long Press
 */

import 'package:flutter/material.dart';

const List<String> regionList = <String>['Philippines (PH)', 'Japan (JP)', 'United States (US)', 'Spain (ES)'];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sign Up',
      theme: ThemeData(
        // This is the theme of your application.
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepOrange,
          primary: Colors.deepOrange,
          secondary: Colors.deepOrangeAccent,
          ),
        fontFamily: 'Roboto',
        textTheme: const TextTheme(
          displayMedium: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(fontSize: 16.0),
          bodyMedium: TextStyle(fontSize: 14.0),
        ),
      ),
      home: const SignUpPage(),
    );
  }
}

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Sign Up'),
      ),
      body: const Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: SignUpForm(),
        ),
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
// == Form Data ==
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _email = '';
  String _password = '';
  String _buttonText = "Click Me";
  String _selectedRegion = regionList.first;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      //  == Form Card ==
      child: Card.outlined(
        //  == Container with Padding ==
        child: Container(
          width: MediaQuery.of(context).size.width * 0.75,
          padding: const EdgeInsets.all(16.0),
          // == Column with Contents =
          child: Column(
            children: [
              // == Image Logo ==
              Image.asset(
                'assets/images/logo.png',
                width: 200,
              ),
              // == Space ==
              SizedBox(height: 16),
              // == Text Components ==
              Text(
                'Create an Account',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              Text(
                'Sign up to get started!',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(height: 16),
              // == Form Widgets ==
              // Username Form
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'Enter your username',
                  labelText: 'Username *'),
                onSaved: (String? value) {
                  _username = value!;
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
              ),
              // Email Form
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.email),
                  hintText: 'Enter your email',
                  labelText: 'Email *'),
                onSaved: (String? value) {
                  _email = value!;
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  } else if (!value.contains('@') || !value.contains('.')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              // Password Form
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.lock),
                  hintText: 'Enter your password',
                  labelText: 'Confirm Password *',
                ),
                obscureText: true,
                onSaved: (value) {
                  _password = value!;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  } else if (value.length < 3) {
                    return 'Password should be at least 3 characters long';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              // Account Region Selection
              DropdownMenu<String>(
                label: const Text('Select Account Region'),
                width: MediaQuery.of(context).size.width * 0.75,
                initialSelection: regionList.first,
                onSelected: (String? value) {
                  // Handle region selection change
                  setState(() {
                    _selectedRegion = value ?? regionList.first;
                  });
                },
                dropdownMenuEntries: regionList.map((String region) {
                  return DropdownMenuEntry(value: region, label: region);
                }).toList(),
              ),

              SizedBox(height: 16),
              // GestureDetector with ElevatedButton with multiple behaviors and logging
              GestureDetector(
                onDoubleTap: () {
                  // Set button text
                  setState(() {
                    _buttonText = "ITP107 - Mobile Application Development";
                  });
                  // Debug console log
                  print("[DEBUG] Button text changed: $_buttonText");
                },
                onLongPress: () {
                  setState(() {
                    _buttonText = "Kurt Lawrence V. Cabrera";
                  });
                  print("[DEBUG] Button text changed to: $_buttonText");
                },
                child: Container(
                  // color: Theme.of(context).colorScheme.inversePrimary,
                  width: MediaQuery.of(context).size.width * 1,
                  padding: const EdgeInsets.all(8),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        // Successful sign-in
                        print("[DEBUG] User signed up - Username: $_username, Email: $_email, Password: $_password, Region: $_selectedRegion");
                      }
                      setState(() {
                        _buttonText = "Hello World!";
                      });

                      print("[DEBUG] Button text changed to: $_buttonText");
                    },
                    child: Text(_buttonText),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
