import 'package:flutter/material.dart';
import 'package:graduation_project101/constants/colors.dart';
import 'package:graduation_project101/views/chat_screen.dart';
import 'package:graduation_project101/views/search/search.dart';

import 'Notifications.dart';
import 'direct_contact/speech_to_text.dart';
import 'direct_contact/text_to_speech.dart';

class ChatHome extends StatefulWidget {
  @override
  _ChatHomeState createState() => _ChatHomeState();
}

class _ChatHomeState extends State<ChatHome> {
  List<ChatUsers> chatUsers = [
    ChatUsers(
        name: 'Nawal',
        imageURL: 'assets/users/Person1.png',
        messageText: 'Hiiiiii',
        time: '6:00 PM'),
    ChatUsers(
        name: 'Akram',
        imageURL: 'assets/users/Person2.png',
        messageText: 'Hiiiiii guys',
        time: '6:00 PM'),
    ChatUsers(
        name: 'Allaa',
        imageURL: 'assets/users/Person3.png',
        messageText: 'I am chating with Nawal',
        time: '6:00 PM'),
    ChatUsers(
        name: 'ali',
        imageURL: 'assets/users/Person1.png',
        messageText: 'Hiiiiii',
        time: '6:00 PM'),
    ChatUsers(
        name: 'rami',
        imageURL: 'assets/users/Person2.png',
        messageText: 'Hiiiiii',
        time: '6:00 PM'),
    ChatUsers(
        name: 'Aya',
        imageURL: 'assets/users/Person3.png',
        messageText: 'Hiiiiii',
        time: '6:00 PM'),
  ];
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 65,
          // centerTitle: true,
          // automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Text(
            'Chat',
            style: TextStyle(
                color: Colors.black, fontSize: 28, fontWeight: FontWeight.bold),
          ),
          leading: GestureDetector(
            // onTap: () => _scaffoldKey.currentState.openDrawer(),
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
                  height: media.height * 0.9,
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
                          width: media.width * 0.9,
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
        body: Container(
          color: Colors.white,
          width: media.width,
          height: media.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: media.height * 0.15,
                  width: media.width,
                  child: ListView.builder(
                      itemCount: chatUsers.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.only(top: 16),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Colors.green, width: 2)),
                                padding: EdgeInsets.all(2),
                                child: CircleAvatar(
                                  backgroundImage:
                                      AssetImage(chatUsers[index].imageURL),
                                  maxRadius: 30,
                                ),
                              ),
                              SizedBox(
                                  width: 50,
                                  child: Center(
                                    child: Text(
                                      chatUsers[index].name,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  )),
                            ],
                          ),
                        );
                      }),
                ),
                ListView.builder(
                  itemCount: chatUsers.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.only(top: 16),
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ConversationList(
                      name: chatUsers[index].name,
                      messageText: chatUsers[index].messageText,
                      imageUrl: chatUsers[index].imageURL,
                      // time: chatUsers[index].time,
                      isMessageRead: (index == 0 || index == 3) ? true : false,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ChatUsers {
  String name;
  String messageText;
  String imageURL;
  String time;
  ChatUsers(
      {@required this.name,
      @required this.messageText,
      @required this.imageURL,
      @required this.time});
}

class ConversationList extends StatefulWidget {
  String name;
  String messageText;
  String imageUrl;
  // String time;
  bool isMessageRead;
  ConversationList(
      {@required this.name,
      @required this.messageText,
      @required this.imageUrl,
      // @required this.time,
      @required this.isMessageRead});
  @override
  _ConversationListState createState() => _ConversationListState();
}

class _ConversationListState extends State<ConversationList> {
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => chatting()));
      },
      child: Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        color: widget.isMessageRead ? Colors.grey[100] : Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(color: Colors.green, width: 2)),
                    padding: EdgeInsets.all(2),
                    child: CircleAvatar(
                      backgroundImage: AssetImage(widget.imageUrl),
                      maxRadius: 30,
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.name,
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(
                            height: 1,
                          ),
                          Text(
                            widget.messageText,
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade600,
                                fontWeight: widget.isMessageRead
                                    ? FontWeight.bold
                                    : FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Text(
            //   // widget.time,
            //   style: TextStyle(
            //       fontSize: 12,
            //       fontWeight: widget.isMessageRead
            //           ? FontWeight.bold
            //           : FontWeight.normal),
            // ),
          ],
        ),
      ),
    );
  }
}
