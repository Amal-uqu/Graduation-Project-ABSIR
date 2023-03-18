import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:tflite/tflite.dart';
import 'package:ABSIR/home_page.dart';
import 'package:ABSIR/settings.dart';
import 'dart:math' as math;

import 'ViewFliteredIMage.dart';
import 'camera.dart';
import 'bndbox.dart';
import 'models.dart';
import 'widgets/gradianticon.dart';

class CameraPage extends StatefulWidget {
  int source;
  bool isRobot;
  CameraPage(this.source, this.isRobot, {Key? key}) : super(key: key);

  @override
  State<CameraPage> createState() => _CameraPageState(source);
}

class _CameraPageState extends State<CameraPage> {
  late int source;
  String __imagePath = "";

  _CameraPageState(source);
  late List<CameraDescription> cameras;
  late List<CameraDescription> cameras2;

  late CameraController cameraController;
  int pageIndex = 0;

  int direction = 0;
  bool done = false;

  final String serverLink = "http://color-blindness-api.net:8000/api/";

  List<String> color_blindness_types = [
    "protanopia",
    "deutranopia",
    "tritanopia",
    "hybrid"
  ];
  String color_blindness_type = "protanopia";

  void startCamera(int direction) async {
    cameras = await availableCameras();
    cameras2 = await availableCameras();

    cameraController = CameraController(
        cameras[direction], ResolutionPreset.high,
        enableAudio: false);
    cameraController.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {
        done = true;
      });
    }).catchError((e) {
      // ignore: avoid_print
      print(e);
    });
  }

  @override
  void initState() {
    startCamera(0);
    super.initState();
  }

  // for recognetion
  late List<dynamic> _recognitions = [];
  int _imageHeight = 0;
  int _imageWidth = 0;
  String _model = "";

  loadModel() async {
    String? res;
    res = await Tflite.loadModel(
      model: "assets/yolov2_tiny.tflite",
      labels: "assets/yolov2_tiny.txt",
    );
    print(res);
  }

  onSelect(model) {
    setState(() {
      _model = model;
    });
    loadModel();
  }

  setRecognitions(recognitions, imageHeight, imageWidth) {
    setState(() {
      _recognitions = recognitions;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
    });
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    onSelect(yolo);
    Size screen = MediaQuery.of(context).size;
    if (done) {
      if (cameraController.value.isInitialized) {
        return Scaffold(
            body: Stack(
          children: [
            pageIndex == 0
                ? Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: HomePageCamera())
                : Stack(
                    children: [
                      Camera(
                        cameras2,
                        _model,
                        setRecognitions,
                      ),
                      BndBox(
                          _recognitions,
                          math.max(_imageHeight, _imageWidth),
                          math.min(_imageHeight, _imageWidth),
                          screen.height,
                          screen.width,
                          _model,
                          widget.isRobot),
                    ],
                  ),
            Align(
              alignment: Alignment.bottomCenter,
              child: CurvedNavigationBar(
                  backgroundColor: Colors.white,
                  buttonBackgroundColor: Colors.transparent,
                  index: 1,
                  height: 65,
                  items: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              pageIndex = 0;
                              startCamera(0);
                            });
                          },
                          child: GradientIcon(
                            Icons.remove_red_eye_rounded,
                            30.0,
                            const LinearGradient(
                              colors: <Color>[
                                Color.fromARGB(255, 193, 218, 255),
                                Color.fromARGB(255, 103, 159, 255),
                                Color.fromARGB(255, 72, 51, 135),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              pageIndex = 1;
                            });
                          },
                          child: GradientIcon(
                            Icons.video_camera_back,
                            30.0,
                            const LinearGradient(
                              colors: <Color>[
                                Color.fromARGB(255, 193, 218, 255),
                                Color.fromARGB(255, 103, 159, 255),
                                Color.fromARGB(255, 72, 51, 135),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GradientIcon(
                          Icons.qr_code,
                          30.0,
                          const LinearGradient(
                            colors: <Color>[
                              Color.fromARGB(255, 193, 218, 255),
                              Color.fromARGB(255, 103, 159, 255),
                              Color.fromARGB(255, 72, 51, 135),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SettingsScreen()),
                            );
                          },
                          child: GradientIcon(
                            Icons.settings,
                            30.0,
                            const LinearGradient(
                              colors: <Color>[
                                Color.fromARGB(255, 193, 218, 255),
                                Color.fromARGB(255, 103, 159, 255),
                                Color.fromARGB(255, 72, 51, 135),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                  letIndexChange: (index) {
                    return false;
                  }),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: 10),
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    if (pageIndex == 0) {
                      cameraController.takePicture().then((XFile file) {
                        if (mounted) {
                          if (file != null) {
                            print('picture saved to ${file.path}');
                          }
                        }
                      });
                    }
                  },
                  child: Container(
                      // height: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color.fromARGB(255, 193, 218, 255),
                            Color.fromARGB(255, 103, 159, 255),
                            Color.fromARGB(255, 72, 51, 135),
                          ],
                        ),
                      ),
                      child: const Icon(
                        Icons.home,
                        size: 30,
                        color: Colors.white,
                      )),
                ),
              ),
            ),
          ],
        ));
      } else {
        return const SizedBox();
      }
    } else {
      return const SizedBox();
    }
  }

  Widget HomePageCamera() {
    return Stack(
      children: [
        CameraPreview(cameraController),
        Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // SizedBox(
              //   width: (MediaQuery.of(context).size.width) / 2,
              // ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    cameraController.takePicture().then((XFile file) {
                      if (mounted) {
                        if (file != null) {
                          __imagePath = file.path;
                          showDialog(
                              context: context,
                              builder: (_) => showPicture(__imagePath));
                        }
                      }
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 60),
                    child: Container(
                      // height: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color.fromARGB(255, 193, 218, 255),
                            Color.fromARGB(255, 103, 159, 255),
                            Color.fromARGB(255, 72, 51, 135),
                          ],
                        ),
                      ),
                      child: const Icon(
                        Icons.camera,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 80),
                child: Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: DropdownButton<String>(
                    value: color_blindness_type,
                    icon: const Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    onChanged: (String? newValue) {
                      setState(() {
                        color_blindness_type = newValue!;
                      });
                    },
                    items: color_blindness_types
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  AlertDialog showPicture(String imagePath) {
    return AlertDialog(
      content: Container(
        // height: 300,
        // width: 300,
        child: Image.file(
          File(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('الغاء')),
        TextButton(
            onPressed: () async {
              // Navigator.pop(context);
              __laoding();
              var res = await uploadImage(imagePath);

              if (res.statusCode == 200) {
                Navigator.pop(context);
                Navigator.pop(context);
                res.stream.bytesToString().then((value) {
                  var data = jsonDecode(value);
                  print(data);
                  String temp = serverLink.replaceAll("api/", "");

                  showDialog(
                      context: context,
                      builder: (_) {
                        return ViewImage(
                          imageLink: temp + data['link'],
                        );
                      });
                });
              } else {
                Navigator.pop(context);
                res.stream.bytesToString().then(
                  (value) {
                    print(value);
                    showDialog(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          content: Text(value),
                        );
                      },
                    );
                  },
                );
              }

              // print res body
            },
            child: const Text('إرسال')),
      ],
    );
  }

  AlertDialog showPictureFomLink(String imageLink) {
    return AlertDialog(
      content: Container(
        child: Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationZ(180 * 3.1415927 / 180),
          child: Image.network(
            imageLink,
            fit: BoxFit.contain,
            scale: 2,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('إلغاء')),
        TextButton(
            onPressed: () async {
              Navigator.pop(context);
            },
            child: const Text('حسنًا')),
      ],
    );
  }

  Future<http.StreamedResponse> uploadImage(String imagePath) async {
    String tempLink = serverLink + "process/";
    var request = http.MultipartRequest('POST', Uri.parse(tempLink));
    request.files.add(await http.MultipartFile.fromPath('image', imagePath));
    request.fields['type'] = color_blindness_type;
    var res = await request.send();
    return res;
  }

  void __laoding() {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              content: Container(
                height: 100,
                width: 100,
                child: Column(
                  children: const [
                    Center(
                      child: CircularProgressIndicator(
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text('جاري المعالجة'),
                  ],
                ),
              ),
            ));
  }
}
