import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ABSIR/signup_screen.dart';

import 'MyButton.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: screenHeight * 0.2,
            width: screenWidth * 0.5,
            child: Image.asset("images/home.jpg"),
            margin: EdgeInsets.only(bottom: screenWidth * 0.1),
          ),
          Container(
            alignment: Alignment.topCenter,
            margin: EdgeInsets.only(bottom: screenWidth * 0.1),
            child: const Text(
              "اهلا بك في تطبيق أبصر",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: screenHeight * 0.15),
          myButton(
              width: screenWidth * 0.8,
              txt: "إنشاء حساب",
              fun: () {
                Navigator.of(context).push(MaterialPageRoute<void>(
                  builder: (BuildContext context) => const SignupScreen(),
                ));
              }),
          SizedBox(height: screenHeight * 0.02),
          myButton(
              width: screenWidth * 0.8,
              txt: "تسجيل الدخول",
              fun: () {
                Navigator.of(context).push(MaterialPageRoute<void>(
                  builder: (BuildContext context) => const LoginScreen(),
                ));
              }),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.fromLTRB(10, 20, 10, 20),
            child: Text.rich(TextSpan(children: [
              const TextSpan(
                  text: ' ',
                  style: TextStyle(
                    fontSize: 18,
                  )),
              TextSpan(
                  text: ' ',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.of(context).push(MaterialPageRoute<void>(
                        builder: (BuildContext context) => const LoginScreen(),
                      ));
                    },
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 19,
                  )),
            ])),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
