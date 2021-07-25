import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project101/constants/colors.dart';
import 'package:graduation_project101/services/auth.dart';
import 'package:graduation_project101/views/signup/SignUp.dart';
import '../home_page.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool showspinner = false;
  bool check = false;
  String _email;
  String _password;
  bool passvisible = true;
  bool isAuth = false;

  @override
  void initState() {
    super.initState();
  }

  final TextEditingController _pass = TextEditingController();

  final TextEditingController email = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _pass.dispose();
    email.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ModalProgressHUD(
          inAsyncCall: showspinner,
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 20.0),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.all(10.0),
                            child: Image(
                              width: 50,
                              image: AssetImage('assets/users/mask.png'),
                            ),
                          ),
                          SizedBox(
                            height: 40.0,
                          ),
                          Container(
                            child: Image(
                              image: AssetImage('assets/users/people.png'),
                            ),
                          ),
                          SizedBox(
                            height: 40.0,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.85,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: email,
                                  decoration: InputDecoration(
                                    labelText: 'Email Addresse',
                                    labelStyle: TextStyle(
                                      fontWeight: FontWeight.w200,
                                    ),
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'Email is Required';
                                    }

                                    if (!RegExp(
                                            r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                        .hasMatch(value)) {
                                      return 'Please enter a valid email Address';
                                    }

                                    return null;
                                  },
                                  onSaved: (String value) {
                                    _email = value;
                                  },
                                ),
                                SizedBox(height: 10.0),
                                TextFormField(
                                  controller: _pass,
                                  decoration: InputDecoration(
                                    labelText: ' Password',
                                    labelStyle: TextStyle(
                                      fontWeight: FontWeight.w200,
                                    ),
                                    border: OutlineInputBorder(),
                                    suffixIcon: IconButton(
                                      icon: Icon(passvisible
                                          ? Icons.visibility
                                          : Icons.visibility_off),
                                      onPressed: () {
                                        setState(() {
                                          passvisible = !passvisible;
                                        });
                                      },
                                    ),
                                  ),
                                  obscureText: passvisible,
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'Password is Required';
                                    }

                                    return null;
                                  },
                                  onSaved: (String value) {
                                    _password = value;
                                  },
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 72,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 2),
                                  child: Text(
                                    'New To beethoven?',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                    ),
                                  )),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 2),
                                child: GestureDetector(
                                  child: Text(
                                    'Register Now!',
                                    style: TextStyle(color: primaryColor),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      showspinner = true;
                                    });
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SignUp(),
                                      ),
                                    );
                                    showspinner = false;
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: 340,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color: primaryColor,
                            ),
                            child: TextButton(
                              child: Text(
                                'Login',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              onPressed: () async {
                                setState(() {
                                  showspinner = true;
                                });
                                if (_formKey.currentState.validate()) {
                                  User user = await Authentication.login(
                                      email.text.trim(), _pass.text.trim());
                                  if (user != null) {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomePage()));
                                  }
                                }
                                showspinner = false;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          GestureDetector(
                            child: Row(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 2),
                                  child: Text(
                                    'Forgot password?',
                                    style: TextStyle(color: primaryColor),
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              Navigator.pushNamed(context, 'Forgot Pass?');
                            },
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
