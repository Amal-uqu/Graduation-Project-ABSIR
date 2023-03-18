import 'package:flutter/material.dart';

class OnbordModel {
  String img;
  String txt;
  String desc;
  OnbordModel({
    required this.img,
    required this.txt,
    required this.desc,
  });
}

List<OnbordModel> screen = <OnbordModel>[
  OnbordModel(
    img: "images/page1.png",
    txt: "أهلا بك في أبصر",
    desc: 'يمكنك من تسجيل صوت شخص مقرب وسماع وصف الأشياء بصوته',
  ),
  OnbordModel(
    img: "images/detection.png",
    txt: "أهلا بك في أبصر ",
    desc: 'يوضح لك الأشياء حولك',
  ),
  OnbordModel(
    img: "images/color blind.png",
    txt: "أهلا بك في أبصر ",
    desc: 'بألوانها الصحيحة',
  ),
];
