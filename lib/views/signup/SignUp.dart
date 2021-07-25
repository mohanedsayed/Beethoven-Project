import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project101/constants/colors.dart';
import 'package:graduation_project101/services/auth.dart';
import 'package:graduation_project101/widgets/navigation_drawer.dart';
import 'package:image_picker/image_picker.dart';
import '../home_page.dart';

class SignUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormScreenState();
  }
}

class FormScreenState extends State<SignUp> {
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
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              color: primaryColor,
              icon: const Icon(
                Icons.arrow_back,
              ),
              onPressed: () {
                Navigator.pop(context, 'HomeScreen');
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: new Stack(
          children: <Widget>[
            Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: firstName,
                            decoration: InputDecoration(
                              labelText: 'First Name',
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
                          TextFormField(
                            controller: lastName,
                            decoration: InputDecoration(labelText: 'Last Name'),
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
                          TextFormField(
                            controller: email,
                            decoration: InputDecoration(labelText: 'Email'),
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
                          TextFormField(
                            controller: _pass,
                            decoration: InputDecoration(
                              labelText: ' Password',
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
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: ' Confirm Password',
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
                          SizedBox(height: 40),
                          imagePath == null
                              ? GestureDetector(
                                  onTap: () => getImage(ImageSource.gallery),
                                  child: Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    decoration: BoxDecoration(
                                        color: iconBackgroundColor,
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.photo,
                                          color: primaryColor,
                                          size: 40,
                                        ),
                                        SizedBox(width: 5),
                                        Text('Add Profile Picture'),
                                      ],
                                    ),
                                  ),
                                )
                              : Container(
                                  child: Image.file(
                                    File(imagePath),
                                  ),
                                ),
                          SizedBox(height: 40),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      width: 280,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: primaryColor,
                      ),
                      child: TextButton(
                        child: Text(
                          'Sign Up',
                          style: TextStyle(color: Colors.white, fontSize: 25),
                          //style: kBodyText.copyWith(fontWeight: FontWeight.bold),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            User user = await Authentication.signUp(
                                email.text.trim(), _pass.text.trim());
                            print(user);
                            Authentication.createUser(
                                firstName.text.trim(),
                                lastName.text.trim(),
                                email.text.trim(),
                                imagePath);
                            if (user != null) {
                              print(user);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()));
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
