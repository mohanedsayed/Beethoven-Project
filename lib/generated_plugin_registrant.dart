//
// Generated file. Do not edit.
//

// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter_tts/flutter_tts_web.dart';
import 'package:image_picker_for_web/image_picker_for_web.dart';
import 'package:speech_to_text/speech_to_text_web.dart';
import 'package:video_player_web/video_player_web.dart';
import 'package:wakelock_web/wakelock_web.dart';

import 'package:flutter_web_plugins/flutter_web_plugins.dart';

// ignore: public_member_api_docs
void registerPlugins(Registrar registrar) {
  FlutterTtsPlugin.registerWith(registrar);
  ImagePickerPlugin.registerWith(registrar);
  SpeechToTextPlugin.registerWith(registrar);
  VideoPlayerPlugin.registerWith(registrar);
  WakelockWeb.registerWith(registrar);
  registrar.registerMessageHandler();
}
