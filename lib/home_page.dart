
import 'package:flutter/material.dart';
import 'package:ABSIR/voice.dart';

import 'camera_home.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int button = 0;

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
              ],
            )
          ),

        child: Container(
          margin: const  EdgeInsets.only(left: 30, right: 30),
          child: Column(
            children: [
              const SizedBox(height: 100,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  'http://clipart-library.com/images_k/health-clipart-transparent/health-clipart-transparent-20.png',
                  width: 200,
                  height: 200,
                ),
              ),
              
              const SizedBox(height: 50,),
              const Text(
                'اختيار الصوت',
                style: TextStyle(
                  color: Color(0xFF9361E3),
                  fontSize:30,
                  fontWeight: FontWeight.bold
                )
              ),
              InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const VoicePage()),
                  );
                },
                child: Card(
                  elevation:2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                      //set border radius more than 50% of height and width to make circle
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          button != 1 ?const Color(0x773AD3D4):const Color(0xBB3AD3D4),
                          button != 1 ?const Color(0x779361E3):const Color(0xBB9361E3),
                        ],
                      )
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const  [
                        Text(
                          'تسجيل صوت شخص مقرب',
                          style: TextStyle(
                            fontSize:20,
                            fontWeight: FontWeight.bold
                          )
                        ),
                        Text(
                          'يمكنك تسجيل صوت أخ أو صديق و سماع الجمل بصوته',
                          style: TextStyle(
                            fontSize:18,
                            // fontWeight: FontWeight.bold
                          )
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CameraPage(1,true)),
                  );
                },
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                      //set border radius more than 50% of height and width to make circle
                  ),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient:const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0x773AD3D4),
                          Color(0x779361E3)
                        ],
                      )
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const  [
                        Text(
                          'الصوت الإفتراضي',
                          style: TextStyle(
                            fontSize:20,
                            fontWeight: FontWeight.bold
                          )
                        ),
                        Text(
                          'يمكنك من سماع صوت الإفتراضي',
                          style: TextStyle(
                            fontSize:18,
                          )
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}