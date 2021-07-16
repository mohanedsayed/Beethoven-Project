import 'package:flutter/material.dart';
import 'package:graduation_project101/widgets/videoPlayerWidget.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  @override
  _VideoScreenState createState() => _VideoScreenState();
}

var videoPath;

class _VideoScreenState extends State<VideoScreen> {
  VideoPlayerController controller;
  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.file(videoPath)
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((_) => controller.play());
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMuted = controller.value.volume == 0;
    return Column(
      children: [
        VideoPlayerWidget(controller: controller),
        const SizedBox(
          height: 32,
        ),
        if (controller != null && controller.value.isInitialized)
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.red,
            child: IconButton(
              onPressed: () => controller.setVolume(isMuted ? 1 : 0),
              icon: Icon(isMuted ? Icons.volume_mute : Icons.volume_up),
              color: Colors.white,
            ),
          ),
      ],
    );
  }
}
