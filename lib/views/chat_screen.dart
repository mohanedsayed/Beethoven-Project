import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:graduation_project101/constants/colors.dart';

final _firestore = FirebaseFirestore.instance;
User loggedInUser;

class chatting extends StatefulWidget {
  @override
  _chattingState createState() => _chattingState();
}

class _chattingState extends State<chatting> {
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  String messageText;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    //sync not async
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        // print("email is : ${loggedInUser.email}");
      }
      //await getMessages();
    } catch (e) {
      print(e);
    }
  }

  // getMessages() async {
  //   final messages = await _firestore
  //       .collection('messages')
  //       .get(); //query snapshot [Query Document snapshot]
  //   messages.docs.forEach((element) {
  //     print(element.data()['sender']);
  //     print(element.data()['text']);
  //   });
  // }
  // void messagesStream() async {
  //   await for (var snapshot in _firestore.collection('messages').snapshots()) {
  //     for (var message in snapshot.docs) {
  //       print(message.data());
  //     }
  //   }
  // }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Icon(
              Icons.arrow_back,
              color: Colors.black87,
              size: 30,
            ),
          ),
        ),
        toolbarHeight: 50,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        // centerTitle: true,
        title: Text(
          "Chat",
          style: TextStyle(
              fontSize: 28, color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        // flexibleSpace: Row(
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   children: [
        //     Padding(
        //       padding: const EdgeInsets.symmetric(vertical: 25.0),
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         mainAxisAlignment: MainAxisAlignment.start,
        //         children: [
        //           Text(
        //             "Chat",
        //             style: TextStyle(
        //               fontSize: 14,
        //               color: Colors.black87,
        //               fontStyle: FontStyle.normal,
        //             ),
        //           ),
        //           SizedBox(height: 5),
        //           // Text(
        //           //   "Online",
        //           //   style: TextStyle(
        //           //       fontSize: 8,
        //           //       color: Colors.black87,
        //           //       fontStyle: FontStyle.normal,
        //           //       fontWeight: FontWeight.w400),
        //           // ),
        //         ],
        //       ),
        //     ),
        //     //   Spacer(),
        //     //   Container(
        //     //     decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
        //     //       BoxShadow(
        //     //         blurRadius: 0.1,
        //     //         color: Colors.blue[50],
        //     //       ),
        //     //     ]),
        //     //       child: Icon(
        //     //         Icons.call,
        //     //         size: 22,
        //     //         color: Colors.blue[600],
        //     //       ),
        //     //     ),
        //     //     SizedBox(
        //     //       width: 20,
        //     //     ),
        //     //     Container(
        //     //       decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
        //     //         BoxShadow(
        //     //           blurRadius: 0.1,
        //     //           color: Colors.blue[50],
        //     //         )
        //     //       ]),
        //     //       child: Icon(
        //     //         Icons.video_call,
        //     //         size: 22,
        //     //         color: Colors.blue[600],
        //     //       ),
        //     //     ),
        //     //     SizedBox(
        //     //       width: 15,
        //     //     )
        //     //   ),
        //   ],
        // ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessagesStream(),
            Container(
              decoration: BoxDecoration(),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 3.0, left: 2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 0.2,
                        color: Colors.black12,
                      ),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.emoji_emotions_rounded,
                        color: Colors.grey[400],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(17.0),
                        border: Border.all(
                          width: 0.01,
                          color: Colors.black87,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: TextField(
                          textAlign: TextAlign.left,
                          controller: messageTextController,
                          onChanged: (value) {
                            messageText = value;
                          },
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.text,
                          decoration: new InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            hintText: ' Write Your Message',
                            hintStyle: TextStyle(
                              color: Colors.black45,
                            ),
                            // suffixIcon:
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.camera_alt,
                        color: primaryColor,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      GestureDetector(
                        onTap: () => showModalBottomSheet(
                          context: context,
                          builder: (context) => Container(
                              child: GridView.count(
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 10,
                            crossAxisCount: 2,
                            children: List.generate(8, (index) {
                              return Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20.0),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          )),
                        ),
                        child: Icon(
                          Icons.attach_file_sharp,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Container(
                        margin: EdgeInsets.only(right: 2.0, left: 2.0),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 0.2,
                            color: Colors.black12,
                          ),
                        ),
                        child: IconButton(
                          onPressed: () {
                            messageTextController.clear();
                            _firestore.collection('messages').add({
                              'text': messageText,
                              'sender': loggedInUser.email
                            });
                          },
                          icon: Icon(
                            Icons.send_sharp,
                            color: Colors.white,
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('messages').snapshots(),
      builder: (BuildContext context, snapshot) {
        List<MessageBubble> messageBubbles = [];
        print('We enter stream');
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        //connection state => xxxx in stream every new message steam called

        final messages = snapshot?.data?.docs?.reversed;
        print('We enter if in stream');
        for (var message in messages) {
          print('We enter loop in stream');
          final messageText = message['text'] ?? 'No text';
          final messageSender = message['sender'] ?? 'No sender';
          final currentUser = loggedInUser.email;

          final messageBubble = MessageBubble(
            sender: messageSender,
            text: messageText,
            isMe: currentUser == messageSender,
          );

          messageBubbles.add(messageBubble);
          print('We add in list');
        }

        print('Before expanded');
        return Expanded(
          child: ListView(
            reverse: true,
            children: messageBubbles,
          ),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({this.sender, this.text, this.isMe});
  final String sender;
  final String text;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: TextStyle(fontSize: 12.0, color: Colors.black54),
          ),
          Material(
              borderRadius: isMe
                  ? BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      bottomLeft: Radius.circular(30.0),
                      bottomRight: Radius.circular(30.0))
                  : BorderRadius.only(
                      topRight: Radius.circular(30.0),
                      bottomLeft: Radius.circular(30.0),
                      bottomRight: Radius.circular(30.0)),
              elevation: 5.0,
              color: isMe ? primaryColor : Colors.white,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
                child: Text(
                  text,
                  style: TextStyle(
                    color: isMe ? Colors.white : Colors.black54,
                    fontSize: 15.0,
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
