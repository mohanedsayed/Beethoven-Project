import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project101/constants/colors.dart';
import 'package:graduation_project101/views/profile.dart';

final usersRef = FirebaseFirestore.instance.collection('users');
FirebaseAuth auth = FirebaseAuth.instance;

class NavigationDrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(child: DrawerContainer());
  }
}

class DrawerContainer extends StatefulWidget {
  const DrawerContainer({
    Key key,
  }) : super(key: key);

  @override
  _DrawerContainerState createState() => _DrawerContainerState();
}

class _DrawerContainerState extends State<DrawerContainer> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('users').snapshots();
  String userFName = '';
  String userLName = '';
  @override
  void initState() {
    getUserById();
    super.initState();
  }

  Future<DocumentSnapshot> getUserById() async {
    DocumentSnapshot userData = await usersRef.doc(auth.currentUser.uid).get();
    // .then((DocumentSnapshot doc) {
    //   print(doc.id);
    //   print(doc.data().toString());
    // });

    setState(() {
      userFName = userData.get('fName');
      userLName = userData.get('lName');
    });
    return userData;
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    return StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return Stack(
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Image(
                        image: AssetImage("assets/users/drawerBackground.png"),
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10, top: 10),
                            padding:
                                EdgeInsets.only(bottom: 10, left: 15, top: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Mohaned',
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Sayed',
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  auth.currentUser.email,
                                  style: TextStyle(color: fadedTextColor),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: backgroundColor,
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Profile(),
                                ),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 25),
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 0.1,
                                      spreadRadius: 0.2,
                                      color: Colors.grey,
                                    )
                                  ],
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12)),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                              child: Row(
                                children: [
                                  Icon(Icons.person_outline),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    'Profile',
                                  )
                                ],
                              ),
                            ),
                          ),
                          Divider(
                            thickness: 1,
                          ),
                          DrawerTile(
                            icon: Icons.help_outline,
                            text: 'Help Center',
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top: 5, left: 25, right: 25, bottom: 15),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 0.1,
                                    spreadRadius: 0.2,
                                    color: Colors.grey,
                                  )
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12)),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                            child: Row(
                              children: [
                                Icon(Icons.info_outline),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'About',
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            thickness: 1,
                          ),
                          DrawerTile(
                            text: 'Settings',
                            icon: Icons.settings_outlined,
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top: 5, left: 25, right: 25, bottom: 20),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 0.1,
                                    spreadRadius: 0.2,
                                    color: Colors.grey,
                                  )
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12)),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.info_outline,
                                  color: Colors.red,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'Sign Out',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 80,
                left: 25,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage('assets/users/person.jpg'),
                  ),
                ),
              ),
            ],
          );
        });
  }
}

class DrawerTile extends StatelessWidget {
  final String text;
  final IconData icon;

  const DrawerTile({
    Key key,
    this.text,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12, horizontal: 25),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          blurRadius: 0.1,
          spreadRadius: 0.2,
          color: Colors.grey,
        )
      ], color: Colors.white, borderRadius: BorderRadius.circular(12)),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: GestureDetector(
        child: Row(
          children: [
            Icon(icon),
            SizedBox(
              width: 8,
            ),
            Text(
              text,
            )
          ],
        ),
      ),
    );
  }
}
