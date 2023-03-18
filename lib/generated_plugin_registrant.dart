import 'package:audioplayers/audioplayers_web.dart';
import 'package:camera_web/camera_web.dart';
import 'package:flutter_sound_web/flutter_sound_web.dart';
import 'package:speech_to_text/speech_to_text_web.dart';
import 'package:text_to_speech_web/text_to_speech_web.dart';

import 'package:flutter_web_plugins/flutter_web_plugins.dart';

// ignore: public_member_api_docs
void registerPlugins(Registrar registrar) {
  AudioplayersPlugin.registerWith(registrar);
  CameraPlugin.registerWith(registrar);
  FlutterSoundPlugin.registerWith(registrar);
  SpeechToTextPlugin.registerWith(registrar);
  TextToSpeechWeb.registerWith(registrar);
  registrar.registerMessageHandler();
}
