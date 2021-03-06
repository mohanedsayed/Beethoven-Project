import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:graduation_project101/constants/colors.dart';
import 'package:graduation_project101/views/direct_contact/speech_to_text.dart';
import 'package:graduation_project101/views/direct_contact/text_to_speech.dart';
import 'package:graduation_project101/widgets/comment_container.dart';
import 'package:graduation_project101/widgets/createPost.dart';
import 'package:graduation_project101/widgets/navigation_drawer.dart';
import 'package:graduation_project101/widgets/post_container.dart';
import 'direct_contact/test.dart';
import 'search/search.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<Widget> posts = [PostContainer(), PostContainer()];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        isExtended: true,
        backgroundColor: primaryColor,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CreatePost()));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 38,
        ),
      ),
      key: _scaffoldKey,
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text(
          'Home',
          style: TextStyle(
              color: Colors.black, fontSize: 28, fontWeight: FontWeight.bold),
        ),
        leading: GestureDetector(
          onTap: () => _scaffoldKey.currentState.openDrawer(),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://www.diethelmtravel.com/wp-content/uploads/2016/04/bill-gates-wealthiest-person.jpg'),
            ),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => Search())),
            child: CircleAvatar(
              backgroundColor: iconBackgroundColor,
              radius: 20,
              child: Icon(
                Icons.search,
                size: 28,
                color: primaryColor,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => TTSpeech())),
            child: CircleAvatar(
              backgroundColor: iconBackgroundColor,
              radius: 20,
              child: Icon(
                Icons.keyboard,
                size: 28,
                color: primaryColor,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () => showModalBottomSheet(
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              context: context,
              builder: (context) => Container(
                height: size.height * 0.9,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Image(
                        image: AssetImage('assets/users/direct_contact.png'),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      'Direct Contact',
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 24,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10),
                      child: Text(
                        'Our app can recognise the the audio it listens to and converts it into text.',
                        style: TextStyle(),
                        softWrap: true,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: SizedBox(),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SpeechToTextScreen(),
                          ),
                        );

                        // Navigator.pop(context);
                      },
                      child: Container(
                        height: 50,
                        width: size.width * 0.9,
                        decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(18)),
                        child: Center(
                          child: Text(
                            'Start Contacting',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: SizedBox(),
                    ),
                  ],
                ),
              ),
            ),
            child: CircleAvatar(
              backgroundColor: iconBackgroundColor,
              radius: 20,
              child: Icon(Icons.mic, size: 28, color: primaryColor),
            ),
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: Builder(builder: (context) {
        return Container(
          color: Colors.white,
          child: ListView(
            children: posts,
            // padding: EdgeInsets.only(top: 20, left: 16, right: 16),
          ),
        );
      }),
    );
  }
}
