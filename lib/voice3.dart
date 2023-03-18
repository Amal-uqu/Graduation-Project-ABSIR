// import 'dart:html';

import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import 'camera_home.dart';

class VoicePage3 extends StatefulWidget {
  const VoicePage3({key});

  @override
  State<VoicePage3> createState() => _VoicePage3State();
}

class _VoicePage3State extends State<VoicePage3> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = '';
  String t = 'حاسوب';
  final recorder = FlutterSoundRecorder();

  Future<void> record() async {
    // final dir = Directory('/data/user/0/com.example.videoapp2/cache/audio');
    // dir.list();
    // print('hellos${(dir.list().first as File).path}');
    // dir.deleteSync(recursive: true);
    await recorder.startRecorder(toFile: 'audio3');
  }

  Future<void> stop() async {
    final path = await recorder.stopRecorder();
    const snackBar = SnackBar(
      content: Text('تم التسجيل بنجاح'),
    );

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    print('hello $path');
    final audioFile = File(path!);
  }

  Future<void> initRecorder() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw 'MicroPhone permission not granted';
    }

    await recorder.openRecorder();
  }

  @override
  void initState() {
    initRecorder();
    super.initState();
    _speech = stt.SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0x663AD3D4),
            Color(0x77FFFFFF),
            Color(0x229361E3),
            Color(0x77FFFFFF),
            // Color(0xff353068),
          ],
        )),
        child: Container(
          margin: const EdgeInsets.only(left: 30, right: 30),
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),

              const SizedBox(
                height: 50,
              ),
              const Text('اختيار الصوت',
                  style: TextStyle(
                      color: Color(0xff353068),
                      fontSize: 30,
                      fontWeight: FontWeight.bold)),
              // const SizedBox(height: 4,),
              const Text('ابدأ بتسجيل الجملة التالية',
                  style: TextStyle(
                    color: Color(0xff353068),
                    fontSize: 20,
                  )),
              Text(t,
                  style: const TextStyle(
                    color: Color(0xff9361E3),
                    fontSize: 20,
                  )),
              Text(_text,
                  style: const TextStyle(
                    color: Color(0xff9361E3),
                    fontSize: 20,
                  )),
              const SizedBox(
                height: 100,
              ),
              AvatarGlow(
                animate: _isListening,
                glowColor: Color(0xff353068),
                endRadius: 75.0,
                duration: const Duration(milliseconds: 2000),
                repeatPauseDuration: const Duration(milliseconds: 100),
                repeat: true,
                child: InkWell(
                  onTap: _listen,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0x993AD3D4),
                                Color(0x999361E3),
                              ],
                            )),
                        child: const Icon(
                          Icons.keyboard_voice_outlined,
                          color: Color(0xff353068),
                        )),
                  ),
                ),
              ),

              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            if (_text == t) {
                              return Container(
                                padding: const EdgeInsets.all(20),
                                decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0x993AD3D4),
                                    Color(0x999361E3),
                                  ],
                                )),
                                height: 200,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Center(
                                        child: Text('تمت المطابقة',
                                            style: TextStyle(
                                                fontSize: 24,
                                                color: Colors.green))),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CameraPage(1, false)),
                                        );
                                      },
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          //set border radius more than 50% of height and width to make circle
                                        ),
                                        child: Container(
                                          padding: const EdgeInsets.only(
                                              left: 60,
                                              right: 60,
                                              top: 10,
                                              bottom: 10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              gradient: const LinearGradient(
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                                colors: [
                                                  Color(0xFF3AD3D4),
                                                  Color(0xFF9361E3),
                                                ],
                                              )),
                                          child: const Text('التالي',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return Container(
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0x993AD3D4),
                                    Color(0x999361E3),
                                  ],
                                )),
                                height: 200,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Center(
                                        child: Text('تم التسجيل بنجاح ',
                                            style: TextStyle(
                                                fontSize: 24,
                                                color: Color.fromARGB(
                                                    255, 8, 192, 23)))),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CameraPage(1, false)),
                                        );
                                      },
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          //set border radius more than 50% of height and width to make circle
                                        ),
                                        child: Container(
                                          padding: const EdgeInsets.only(
                                              left: 60,
                                              right: 60,
                                              top: 10,
                                              bottom: 10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              gradient: const LinearGradient(
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                                colors: [
                                                  Color(0xFF3AD3D4),
                                                  Color(0xFF9361E3),
                                                ],
                                              )),
                                          child: const Text('التالي',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                        );
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          //set border radius more than 50% of height and width to make circle
                        ),
                        child: Container(
                          width: 200,
                          height: 60,
                          padding: const EdgeInsets.only(
                              left: 60, right: 60, top: 10, bottom: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color(0xFF3AD3D4),
                                  Color(0xFF9361E3),
                                ],
                              )),
                          child: const Text('التالي',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _listen() async {
    if (recorder.isRecording) {
      stop();
    } else {
      record();
    }

    //if (!_isListening) {
    // bool available = await _speech.initialize(
    //   onStatus: (val) => print('onStatus: $val'),
    //   onError: (val) => print('onError: $val'),
    // );

    // if (available) {
    //  setState(() => _isListening = true);

    //  _speech.listen(
    //    localeId: 'ar',
    //  onResult: (val) => setState(() {
    //    _text = val.recognizedWords;
    //    print(_text);

    //  }),
    // );
  }
  // } else {
  //  setState(() => _isListening = false);
  //  _speech.stop();
  //   }
  //}
}
