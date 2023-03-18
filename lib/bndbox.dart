import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
import 'dart:math' as math;
import 'package:text_to_speech/text_to_speech.dart';
import 'models.dart';

class BndBox extends StatefulWidget {
  final List<dynamic> results;
  final int previewH;
  final int previewW;
  final double screenH;
  final double screenW;
  final String model;
  final bool isRobot;


  BndBox(this.results, this.previewH, this.previewW, this.screenH, this.screenW, this.model, this.isRobot);

  @override
  State<BndBox> createState() => _BndBoxState();
}

class _BndBoxState extends State<BndBox> {
  final translator = GoogleTranslator();
  TextToSpeech tts = TextToSpeech();

  final String defaultLanguage = 'ar-AX';
  
  String text = '';
  double volume = 1; // Range: 0-1
  double rate = 1.0; // Range: 0-2
  double pitch = 1.0; // Range: 0-2

  String? language ;
  String? languageCode = 'ar-AX' ;
  List<String> languages = <String>[];
  List<String> languageCodes = <String>[];
  String? voice;

  String st = '';
  bool stop = false;

  // Future<void> initLanguages() async {
  //   /// populate lang code (i.e. en-US)
  //   languageCodes = await tts.getLanguages();

  //   /// populate displayed language (i.e. English)
  //   final List<String>? displayLanguages = await tts.getDisplayLanguages();
  //   if (displayLanguages == null) {
  //     return;
  //   }

  //   languages.clear();
  //   for (final dynamic lang in displayLanguages) {
  //     languages.add(lang as String);
  //   }

  //   final String? defaultLangCode = await tts.getDefaultLanguage();
  //   if (defaultLangCode != null && languageCodes.contains(defaultLangCode)) {
  //     languageCode = defaultLangCode;
  //   } else {
  //     languageCode = defaultLanguage;
  //   }
  //   language = await tts.getDisplayLanguageByCode(languageCode!);

  //   /// get voice
  //   voice = await getVoiceByLang(languageCode!);

  //   if (mounted) {
  //     setState(() {});
  //   }
  // }

  Future<String?> getVoiceByLang(String lang) async {
    final List<String>? voices = await tts.getVoiceByLang('ar-AX');
    if (voices != null && voices.isNotEmpty) {
      return voices.first;
    }
    return null;
  }


  void tran(String s)async{
    var translation = await translator.translate(s, from: 'en', to: 'ar');
    setState(() {
      st = translation.text;
    });
  }

  @override
  void initState() {
    // WidgetsBinding.instance?.addPostFrameCallback((_) {
    //   initLanguages();
    // });
    super.initState();
  }


  void speak(String statment) async{

    if(widget.isRobot){
      if(!stop){
        tts.setVolume(volume);
        tts.setRate(rate);
        if (languageCode != null) {
          tts.setLanguage(languageCode!);
        }
        tts.setPitch(pitch);
        tts.speak(statment);
        stop = true;
      }
      Future.delayed(Duration(seconds: 5),(){
        stop = false;
      });
    } else{
      print(statment);
      if(!stop && (statment == 'keyboard' || statment == 'fork' || statment == 'computer')){
        stop = true;

        final audioplayer = AudioPlayer();

        File? file;

        if(statment == 'keyboard' ){
        file  = File('/data/user/0/com.example.videoapp2/cache/audio');
        }else if(statment == 'fork'){
        file = File('/data/user/0/com.example.videoapp2/cache/audio2');
        }else if(statment == 'computer'){
        file = File('/data/user/0/com.example.videoapp2/cache/audio3');
        }
        
        audioplayer.setUrl(file!.path,isLocal: true);
        await audioplayer.setUrl(file.path,isLocal: true); 
        
        await audioplayer.resume();
        Future.delayed(Duration(seconds: 10),(){
        stop = false;
      });
      }
     
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _renderBoxes() {
      return widget.results.map((re) {
        var _x = re["rect"]["x"];
        var _w = re["rect"]["w"];
        var _y = re["rect"]["y"];
        var _h = re["rect"]["h"];
        var scaleW, scaleH, x, y, w, h;

        if (widget.screenH / widget.screenW > widget.previewH / widget.previewW) {
          scaleW = widget.screenH / widget.previewH * widget.previewW;
          scaleH = widget.screenH;
          var difW = (scaleW - widget.screenW) / scaleW;
          x = (_x - difW / 2) * scaleW;
          w = _w * scaleW;
          if (_x < difW / 2) w -= (difW / 2 - _x) * scaleW;
          y = _y * scaleH;
          h = _h * scaleH;
        } else {
          scaleH = widget.screenW / widget.previewW * widget.previewH;
          scaleW = widget.screenW;
          var difH = (scaleH - widget.screenH) / scaleH;
          x = _x * scaleW;
          w = _w * scaleW;
          y = (_y - difH / 2) * scaleH;
          h = _h * scaleH;
          if (_y < difH / 2) h -= (difH / 2 - _y) * scaleH;
        }
        tran(re["detectedClass"]);
        speak(re["detectedClass"]);
        return Positioned(
          left: math.max(0, x),
          top: math.max(0, y),
          width: w,
          height: h,
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                       
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color.fromARGB(255, 118, 160, 222),
                            Color.fromARGB(255, 103, 159, 255),
                            Color.fromARGB(255, 72, 51, 135),
                          ],
                        ),
                      ),
                    width: double.infinity,
                    padding: EdgeInsets.all(5),
                      // color: Color.fromARGB(255, 57, 6, 81),
                      child: Text(
                        "الوصف",
                        overflow:TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(5),
                      color: Color.fromARGB(255, 57, 6, 81),
                      child: Text(
                        // translation text

                        st,
                        // "${re["detectedClass"]} ",
                        overflow:TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
              Container(
                width: double.infinity,
                height: double.infinity,
                padding: EdgeInsets.only(top: 5.0, left: 5.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color.fromARGB(255, 0, 0, 0),
                    width: 3.0,
                  ),
                ),
                
              ),
            ],
          ),
        );
      }).toList();
    }

    List<Widget> _renderStrings() {
      double offset = -1000;
      return widget.results.map((re) {
        offset = offset + 14;
        return Positioned(
          left: 10,
          top: offset,
          width: widget.screenW,
          height: widget.screenH,
          child: Text(
            "${re["label"]} ${(re["confidence"] * 100).toStringAsFixed(0)}%",
            style: const TextStyle(
              color: Color.fromRGBO(37, 213, 253, 1.0),
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      }).toList();
    }

    List<Widget> _renderKeypoints() {
      var lists = <Widget>[];
      widget.results.forEach((re) {
        var list = re["keypoints"].values.map<Widget>((k) {
          var _x = k["x"];
          var _y = k["y"];
          var scaleW, scaleH, x, y;

          if (widget.screenH / widget.screenW > widget.previewH / widget.previewW) {
            scaleW = widget.screenH / widget.previewH * widget.previewW;
            scaleH = widget.screenH;
            var difW = (scaleW - widget.screenW) / scaleW;
            x = (_x - difW / 2) * scaleW;
            y = _y * scaleH;
          } else {
            scaleH = widget.screenW / widget.previewW * widget.previewH;
            scaleW = widget.screenW;
            var difH = (scaleH - widget.screenH) / scaleH;
            x = _x * scaleW;
            y = (_y - difH / 2) * scaleH;
          }
          return Positioned(
            left: x - 6,
            top: y - 6,
            width: 100,
            height: 12,
            child: Container(
              child: Text(
                "● ${k["part"]}",
                style: TextStyle(
                  color: Color.fromARGB(255, 104, 200, 112),
                  fontSize: 12.0,
                ),
              ),
            ),
          );
        }).toList();

        lists..addAll(list);
      });

      return lists;
    }

    return Stack(
      children: widget.model == mobilenet
          ? _renderStrings()
          : widget.model == posenet ? _renderKeypoints() : _renderBoxes(),
    );
  }
}
