import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project101/constants/colors.dart';
import 'package:graduation_project101/services/auth.dart';
import 'package:graduation_project101/views/login/Login.dart';
import 'package:graduation_project101/widgets/navigation_drawer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../home_page.dart';

class SignUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormScreenState();
  }
}

class FormScreenState extends State<SignUp> {
  bool showspinner = false;
  String _firstname;
  String _lastname;
  String _email;
  String _confirmpassword;
  String _password;
  bool passvisible = true;
  bool passvisible2 = true;
  String imagePath;

  final TextEditingController _pass = TextEditingController();
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  void getImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().getImage(source: imageSource);
    if (pickedFile != null) {
      setState(() {
        imagePath = pickedFile.path;
      });
    } else {
      print('no image chosen or taken');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Scaffold(
          body: ModalProgressHUD(
            inAsyncCall: showspinner,
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.all(15.0),
                            child: Image(
                              width: 50,
                              image: AssetImage('assets/users/mask.png'),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Create an account',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 50.0,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.85,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: firstName,
                                  decoration: InputDecoration(
                                    labelText: 'First Name',
                                    labelStyle: TextStyle(
                                      fontWeight: FontWeight.w200,
                                    ),
                                    border: OutlineInputBorder(),
                                    //prefixIcon: Icon(Icons.person_rounded),
                                  ),
                                  //maxLength: 12,
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'First Name is Required';
                                    }

                                    return null;
                                  },
                                  onSaved: (String value) {
                                    _firstname = value;
                                  },
                                ),
                                SizedBox(height: 10.0),
                                TextFormField(
                                  controller: lastName,
                                  decoration: InputDecoration(
                                    labelText: 'Last Name',
                                    labelStyle: TextStyle(
                                      fontWeight: FontWeight.w200,
                                    ),
                                    border: OutlineInputBorder(),
                                  ),
                                  //maxLength: 12,
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'Last Name is Required';
                                    }
                                    return null;
                                  },
                                  onSaved: (String value) {
                                    _lastname = value;
                                  },
                                ),
                                SizedBox(height: 10.0),
                                TextFormField(
                                  controller: email,
                                  decoration: InputDecoration(
                                    labelText: 'Email  Addresse',
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
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    labelText: ' Repeat Password',
                                    labelStyle: TextStyle(
                                      fontWeight: FontWeight.w200,
                                    ),
                                    border: OutlineInputBorder(),
                                    suffixIcon: IconButton(
                                      icon: Icon(passvisible2
                                          ? Icons.visibility
                                          : Icons.visibility_off),
                                      onPressed: () {
                                        setState(() {
                                          passvisible2 = !passvisible2;
                                        });
                                      },
                                    ),
                                  ),
                                  obscureText: passvisible2,
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'Password is Required';
                                    } else if (value != _pass.text) {
                                      return 'Password does not match';
                                    }

                                    return null;
                                  },
                                  onSaved: (String value) {
                                    _confirmpassword = value;
                                  },
                                ),
                                SizedBox(height: 120),
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 2),
                                            child: Text(
                                              'Already have an account?',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w300,
                                              ),
                                            )),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 2),
                                          child: GestureDetector(
                                            child: Text(
                                              'Login',
                                              style: TextStyle(
                                                  color: primaryColor),
                                            ),
                                            onTap: () {
                                              Navigator.pop(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => Login(),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: 350,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: primaryColor,
                                  ),
                                  child: TextButton(
                                    child: Text(
                                      'Register',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                      //style: kBodyText.copyWith(fontWeight: FontWeight.bold),
                                    ),
                                    onPressed: () async {
                                      setState(() {
                                        showspinner = true;
                                      });
                                      if (_formKey.currentState.validate()) {
                                        User user = await Authentication.signUp(
                                            email.text.trim(),
                                            _pass.text.trim());
                                        print(user);
                                        FirebaseFirestore.instance
                                            .collection('users')
                                            .doc(auth.currentUser.uid)
                                            .set({
                                          'fName': firstName.text.trim(),
                                          'lName': lastName.text.trim(),
                                          'email': email.text.trim(),
                                          'profilePicture': imagePath
                                        });
                                        if (user != null) {
                                          print(user);
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomePage()));
                                        }
                                        setState(() {
                                          showspinner = false;
                                        });
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
