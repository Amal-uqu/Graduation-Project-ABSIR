import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ABSIR/home_page.dart';
import 'package:ABSIR/signup_screen.dart';
import 'package:ABSIR/user_db.dart';

import 'MyButton.dart';
import 'camera_home.dart';
import 'home_screen.dart';
import 'user_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  Color? color = Colors.purple.shade300;
  UserDB userDB = UserDB();


  Future<void> login() async {
    if(emailController.text != '' && passwordController.text != ''){
      
      Map<String,dynamic>? map = await userDB.getUser(emailController.text);
      if(map != null){

        if(map['password'] == passwordController.text){
          Navigator.of(context).popUntil(ModalRoute.withName('/root'));
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CameraPage(1,true)),
        );
        }else{
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('كلمة المرور غير صحيحة'),));
        }
        
      }else{
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('لا يوجد حساب بهذا البريد'),));
      }
      
    }else{
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('ادخل كل الحقول'),));
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: Colors.transparent,
      //   foregroundColor: Colors.black,
      // ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 50,
                padding: EdgeInsets.only(top: 50),
                alignment: Alignment.topLeft,
                child: Stack(
                  children: [
                    Container(),
                    BackButton(),
                  ],
                ),
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(children: [
                    SizedBox(height: screenHeight * 0.14),
                    Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      alignment: Alignment.center,
                      child: const Text(
                        "تسجيل دخول",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                    ),
                    item(
                      text: "البريد الالكتروني",
                      icon: Icons.email_outlined,
                      controller: emailController,
                      validate: (value) =>
                      value!.isEmpty ? "ادخل البريد الالكتروني" : null,
                      width: screenWidth * 0.7,
                      textType: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    item(
                      text: "الرقم السري",
                      icon: Icons.lock_outline,
                      controller: passwordController,
                      validate: (value) =>
                      value!.isEmpty ? "ادخل الرقم السري" : null,
                      width: screenWidth * 0.7,
                      textType: TextInputType.text,
                      scureText: true,
                    ),
                    const SizedBox(height: 20),
                    myButton(
                      width: screenWidth * 0.5,
                      txt: "دخول",
                      fun: () {
                        FocusScope.of(context).unfocus(); // close keybowrd
                        login();
                      },
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      margin: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                      child: Text.rich(TextSpan(children: [
                        const TextSpan(
                            text: 'ليس لديك حساب؟',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            )),
                        TextSpan(
                            text: ' انشاء حساب جديد',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                  const SignupScreen(),
                                ));
                              },
                            style: const TextStyle(
                              color: Colors.purple,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            )),
                      ])),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget item({
    required String text,
    required IconData icon,
    required TextEditingController controller,
    required String? Function(String?) validate,
    required double width,
    bool scureText = false,
    required TextInputType textType,
  }) {
    return Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
      Icon(
        icon,
        size: 35,
        color: color,
      ),
      Container(
        margin: const EdgeInsets.only(top: 10, right: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10)),
              height: 35,
              width: width,
              child: TextFormField(
                validator: validate,
                controller: controller,
                keyboardType: textType,
                obscureText: scureText,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.grey.shade400)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}