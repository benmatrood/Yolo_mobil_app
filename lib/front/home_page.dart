// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../pallette.dart';

// ignore: camel_case_types
class Home_Page extends StatelessWidget {
  const Home_Page({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
     double screenWidth = MediaQuery.of(context).size.width;
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Accueil',
          style:balcktBodyText,
        ),
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
        leading: const BackButton(
          color: Colors.black,
        ),
      ),
      // ignore: prefer_const_constructors
      body: PageView(

      ),
      // ignore: avoid_unnecessary_containers
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(10),
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
          borderRadius: BorderRadius.circular(30),
        ),
        child: NavigationBar(
          
          destinations: const [
            NavigationDestination(

              icon:  Icon(Icons.home),
              label: 'Accueil',
              selectedIcon:  Icon(Icons.home),
            ),
             NavigationDestination(
              icon: Icon(Icons.home),
              label: 'Accueil',
              selectedIcon: Icon(Icons.home),
              
            ),

           
          ],
          
          // items: const <BottomNavigationBarItem>[
            
          //   BottomNavigationBarItem(
          //     icon: Icon(Icons.home),
          //     label: 'Accueil',
          //   ),
          //   BottomNavigationBarItem(
          //     icon: Icon(Icons.forum_outlined),
          //    label: 'Accueil',
          //   ),
          //   BottomNavigationBarItem(
          //     icon: Icon(Icons.graphic_eq_sharp),
          //    label: 'Accueil',
          //   ),
          //   BottomNavigationBarItem(
          //     icon: Icon(Icons.person_rounded),
          //     label: 'Accueil',
          //   ),
          // ],
          
          // currentIndex: 0,
          // selectedItemColor: Colors.black,
          // unselectedItemColor: Colors.grey,
          // backgroundColor: Colors.white,
          // elevation: 0,
          // type: BottomNavigationBarType.fixed,
        ),
      ),
      
    );  
  }
}