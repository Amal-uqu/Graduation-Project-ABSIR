import 'package:flutter/material.dart';

class ViewImage extends StatelessWidget {
  final String imageLink;
  const ViewImage({required this.imageLink, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('رؤية الصورة'),
      ),
      body: Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationZ(90 * 3.1415927 / 180),
        child: Image(
          image: NetworkImage(imageLink),
          fit: BoxFit.contain,

          // scale: 2,
          width: MediaQuery.of(context).size.width * 1,
          height: MediaQuery.of(context).size.height * 1,
        ),
      ),
    );
  }
}
