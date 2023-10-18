import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String _loginFailed = '';
  bool loginSuccessful = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MediTracker Login'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 50,
                width: 200,
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: 50,
                width: 200,
                child: TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  String email = _emailController.text;
                  String password = _passwordController.text;

                  // Call the server API to validate login
                  var response = await http.post(
                    Uri.parse('http://127.0.0.1:5000/login'),
                    body: {
                      'email': email,
                      'password': password,
                    },
                  );
                  //it works if it is true always
                  //need to make it work when actual response is asked
                  //made it work after resinstalling mysql-connector-python
                  if (response.statusCode == 200) {
                    // Login successful
                    setState(() {
                      loginSuccessful = true;
                    });
                    Navigator.pushReplacementNamed(context, '/home');
                  } else {
                    // Login failed, show error message
                    setState(() {
                      loginSuccessful = false;
                      _loginFailed = "Login Failed. Please try again.";
                    });
                  }
                },
                child: Text('Login'),
              ),
              Text(
                _loginFailed,
                style: TextStyle(color: Colors.red),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            SignupPage()), // Navigate to the SignupPage widget
                  );
                  // Navigate to the signup page
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => SignupPage()));
                },
                child: Text('Create an account'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  String _signupMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MediTracker Signup'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 50,
                width: 200,
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: 50,
                width: 200,
                child: TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: 50,
                width: 200,
                child: TextField(
                  controller: _confirmPasswordController,
                  decoration: InputDecoration(labelText: 'Confirm Password'),
                  obscureText: true,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  String email = _emailController.text;
                  String password = _passwordController.text;
                  String confirmPassword = _confirmPasswordController.text;

                  // Check if password and confirm password match
                  if (password == confirmPassword) {
                    // Call the server API to handle signup
                    var response = await http.post(
                      Uri.parse('http://127.0.0.1:5000/signup'),
                      body: {
                        'email': email,
                        'password': password,
                      },
                    );

                    if (response.statusCode == 200) {
                      // Signup successful
                      setState(() {
                        _signupMessage = 'Signup successful!';
                      });
                    } else if (response.statusCode == 409) {
                      setState(() {
                        _signupMessage =
                            'Email already exists please try again';
                      });
                    } else {
                      // Signup failed, show error message
                      setState(() {
                        _signupMessage = 'Signup failed. Please try again.';
                      });
                    }
                  } else {
                    setState(() {
                      _signupMessage =
                          'Passwords do not match. Please try again.';
                    });
                  }
                },
                child: Text('Signup'),
              ),
              Text(
                _signupMessage,
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
