import 'package:flutter/material.dart';

class MyTextButton extends StatelessWidget {
  const MyTextButton(
      {this.context, required this.text, required this.fun, Key? key})
      : super(key: key);
  final BuildContext? context;
  final String text;
  final Function() fun;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size.fromHeight(50),
        maximumSize: const Size.fromHeight(70),
        shape: const StadiumBorder(),
        side: BorderSide(width: 2, color: Theme.of(context).primaryColor),
        padding: const EdgeInsets.symmetric(vertical: 5),
      ),
      onPressed: fun,
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }
}

Widget myButton({
  required double width,
  required String txt,
  required Function() fun,
  Color color = Colors.white,
}) {
  return InkWell(
    onTap: fun,
    child: Container(
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          // الوان متدرجه
          colors: [
            Color.fromARGB(141, 41, 167, 79),
            Color.fromARGB(223, 123, 51, 255),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomCenter,
        ),
      ),
      width: width,
      child: Text(
        txt,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 17,
        ),
      ),
    ),
  );
}
