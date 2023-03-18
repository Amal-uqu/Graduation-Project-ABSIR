import 'package:flutter/material.dart';
import 'package:ABSIR/home_screen.dart';
import 'package:ABSIR/onbord_model.dart';


class OnBoard extends StatefulWidget {
  const OnBoard({Key? key}) : super(key: key);

  @override
  _OnBoardState createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  int currentIndex = 0;
  late PageController _pageController;
  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  storeOwnerInf() {
    int isViewed = 0;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: PageView.builder(
          itemCount: screen.length,
          controller: _pageController,
          onPageChanged: (int index) {
            setState(() {
              currentIndex = index;
            });
          },
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: ((context, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  screen[index].txt,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown,
                  ),
                ),
                const Spacer(flex: 1),
                SizedBox(
                    width: screenWidth,
                    height: screenHeight * 0.5,
                    child: Image.asset(
                      screen[index].img,
                      fit: BoxFit.contain,
                    )),
                const Spacer(flex: 1),
                Text(
                  screen[index].desc,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown,
                  ),
                ),
                const Spacer(flex: 1),
                SizedBox(
                  height: 10,
                  child: ListView.builder(
                    itemCount: screen.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: ((_, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 3),
                            width: currentIndex == index ? 25 : 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: currentIndex == index
                                  ? Colors.brown
                                  : const Color.fromARGB(167, 122, 51, 255)
                                  .withOpacity(0.5),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ),
                const Spacer(flex: 2),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const HomeScreen();
                              },
                            ),
                          );
                        },
                        child: Text(
                          "تخطـي",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.brown.shade700,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          if (index == screen.length - 1) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const HomeScreen();
                                },
                              ),
                            );
                          }
                          _pageController.nextPage(
                              duration: const Duration(microseconds: 1000),
                              curve: Curves.bounceIn);
                        },
                        child: Text(
                          "الـتــالـي",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.brown.shade700,
                          ),
                        ),
                      ),

                      // InkWell(
                      //   onTap: () {
                      //     if (index == screen.length - 1) {
                      //       Navigator.pushReplacement(context,
                      //           MaterialPageRoute(
                      //         builder: (context) {
                      //           return const HomeScreen();
                      //         },
                      //       ));
                      //     }
                      //     _pageController.nextPage(
                      //         duration: const Duration(microseconds: 1000),
                      //         curve: Curves.bounceIn);
                      //   },
                      //   child: Container(
                      //     margin: const EdgeInsets.only(bottom: 20),
                      //     padding: const EdgeInsets.symmetric(
                      //         horizontal: 30, vertical: 10),
                      //     decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(20),
                      //       gradient: const LinearGradient(
                      //         // الوان متدرجه
                      //         colors: [
                      //           Color.fromARGB(108, 78, 90, 252),
                      //           Color.fromARGB(167, 63, 99, 255),
                      //           Color.fromARGB(155, 41, 80, 255),
                      //           Color.fromARGB(167, 118, 59, 230),
                      //         ],
                      //         begin: Alignment.topLeft,
                      //         end: Alignment.bottomRight,
                      //       ),
                      //     ),
                      //     child: Row(
                      //       mainAxisSize: MainAxisSize.min,
                      //       children: const [
                      //         Text(
                      //           "التالي",
                      //           style: TextStyle(
                      //             fontSize: 16,
                      //             color: Colors.white,
                      //             fontWeight: FontWeight.bold,
                      //           ),
                      //         ),
                      //         SizedBox(width: 15),
                      //         Icon(
                      //           Icons.arrow_forward_sharp,
                      //           color: Colors.white,
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                    ]),
              ],
            );
          }),
        ),
      ),
    );
  }
}
