import 'package:flutter/material.dart';
import 'package:graduation_project101/constants/colors.dart';
import 'package:graduation_project101/widgets/post_icon.dart';
import 'package:graduation_project101/widgets/post_interaction.dart';
import 'package:graduation_project101/widgets/threeDots_container.dart';
import 'package:graduation_project101/widgets/veritical_divider.dart';

import 'comment_container.dart';

class PostContainer extends StatefulWidget {
  const PostContainer({
    Key key,
  }) : super(key: key);

  @override
  _PostContainerState createState() => _PostContainerState();
}

class _PostContainerState extends State<PostContainer> {
  final bool hidden = false;

  bool agreePressed = false;

  bool sharePressed = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20, left: 16, right: 16, bottom: 20),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.grey[400], blurRadius: 18),
          ],
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                  backgroundImage: AssetImage('assets/users/person.jpg')),
              SizedBox(width: 10),
              Column(
                children: [
                  Text(
                    'James jones',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    " ${DateTime.now().day.toString()}/${DateTime.now().month}/${DateTime.now().year} , ${DateTime.now().hour} : ${DateTime.now().minute} AM",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w200),
                  ),
                ],
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 4),
            child: Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit.Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
          ),
          Divider(
            thickness: 1.5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    agreePressed = !agreePressed;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.thumb_up_alt_outlined,
                        color:
                            agreePressed == false ? Colors.grey : primaryColor,
                        size: 21,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Agree',
                        style: TextStyle(
                            fontWeight: FontWeight.w200,
                            color: agreePressed == false
                                ? fadedTextColor
                                : primaryColor),
                      )
                    ],
                  ),
                ),
              ),
              VerticalDivider1(),
              GestureDetector(
                onTap: () {
                  setState(() {
                    sharePressed = !sharePressed;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.share_outlined,
                        color:
                            sharePressed == false ? Colors.grey : primaryColor,
                        size: 21,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Share',
                        style: TextStyle(
                            fontWeight: FontWeight.w200,
                            color: sharePressed == false
                                ? fadedTextColor
                                : primaryColor),
                      )
                    ],
                  ),
                ),
              ),
              VerticalDivider1(),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      return CommentContainer();
                    },
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    children: [
                      PostIcon(icon: Icons.mode_comment_outlined),
                      SizedBox(
                        width: 5,
                      ),
                      PostInteraction(
                        text: 'Comment',
                      ),
                    ],
                  ),
                ),
              ),
              // SizedBox(
              //   width: 40,
              // ),
              Spacer(),
              PostIcon(
                onPressed: () => showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) => ThreeDots(),
                ),
                icon: Icons.more_horiz,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
