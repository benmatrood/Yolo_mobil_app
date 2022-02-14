import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yolo/front/view/chatbot.dart';
import 'package:yolo/front/view/home.dart';
import 'package:yolo/front/view/ia.dart';
import 'package:yolo/front/view/profile.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  late Map user;
  final VoidCallback singOut;

  HomePage({Key? key, required this.user, required this.singOut})
      : super(key: key);
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  // ignore: unused_field

  final PageController _pageController = PageController(initialPage: 0);
  int currentIndex = 0;

  @override
  dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Accueil',
      //     style:balcktBodyText,
      //   ),
      //   centerTitle: true,
      //   // elevation: 10,
      //   backgroundColor: Colors.white,
      //   leading: const BackButton(
      //     color: Colors.black,
      //   ),
      // ),
      body: PageView(
        // pour scroller les pages
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        controller: _pageController,
        children: <Widget>[
          HomeView(user: widget.user, singOut: widget.singOut),
          const ChatBotView(),
          const IaView(),
          ProfileView(
            user: widget.user,
            singOut: () {},
          ),
        ],
      ),
      bottomNavigationBar: Container(
        // margin: const EdgeInsets.all(10),
        height: screenWidth * .15,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.15),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
          // borderRadius: BorderRadius.circular(30),
        ),

        child: ListView.builder(
          itemCount: 4,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: screenWidth * .024),
          itemBuilder: (context, index) => InkWell(
            // currentIndex: _currentIndex,
            onTap: () {
              setState(() {
                currentIndex = index;
                // print(index);
                _pageController.jumpToPage(index);
                HapticFeedback.lightImpact();
              });
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Stack(
              children: [
                SizedBox(
                  width: screenWidth * .2125,
                  child: Center(
                    child: AnimatedContainer(
                      duration: const Duration(seconds: 1),
                      curve: Curves.fastLinearToSlowEaseIn,
                      height: index == currentIndex ? screenWidth * .12 : 0,
                      width: index == currentIndex ? screenWidth * .2125 : 0,
                      decoration: BoxDecoration(
                        color: index == currentIndex
                            ? Colors.yellowAccent.withOpacity(.2)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: screenWidth * .2125,
                  alignment: Alignment.center,
                  child: Icon(
                    listOfIcons[index],
                    size: screenWidth * .076,
                    color: index == currentIndex
                        ? const Color.fromRGBO(255, 204, 0, .8)
                        : Colors.black.withOpacity(.7),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<IconData> listOfIcons = [
    Icons.home,
    Icons.forum_outlined,
    Icons.graphic_eq_sharp,
    Icons.person_rounded,
  ];
}
